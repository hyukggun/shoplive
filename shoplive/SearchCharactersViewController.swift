//
//  SearchCharactersViewController.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Combine
import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class SearchCharactersViewController: UIViewController, View {
    typealias Reactor = SearchCharactersReactor<MarvelCharacter>
    
    private enum Constant {
        static var minimumLineSpacing: CGFloat {
            10
        }
        static var contentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        }
    }
    
    private let searchCharcterBar = UISearchBar()
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    private lazy var characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    private let activityView = UIActivityIndicatorView()
    
    private var cellModels: [MarvelCharacterInfoCellModel] = []
    
    private var cancelBag = Set<AnyCancellable>()
    
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setCharacterCollectionView()
        setCharacterSearchBar()
    }
    
    private func setup() {
        view.addSubview(characterCollectionView)
        view.addSubview(searchCharcterBar)
        view.addSubview(activityView)
        
        searchCharcterBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        characterCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchCharcterBar.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        characterCollectionView.contentInset = Constant.contentInset

        activityView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setCharacterCollectionView() {
        characterCollectionView.register(MarvelCharacterInfoCell.self)
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
    }
    
    private func setCharacterSearchBar() {
        searchCharcterBar.placeholder = "캐릭터 이름을 입력해주세요"
    }
    
    func bind(reactor: Reactor) {
        reactor.action.onNext(.fetchCharacters)
        reactor.state.map { $0.cellModels }
            .asDriver(onErrorJustReturn: [])
            .drive(with: self) {
                $0.cellModels = $1
                $0.characterCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.loading }
            .asDriver(onErrorDriveWith: .never())
            .drive(with: self) {
                if $1 {
                    $0.activityView.startAnimating()
                } else {
                    $0.activityView.stopAnimating()
                }
            }
            .disposed(by: disposeBag)
        
        searchCharcterBar.rx
            .text
            .distinctUntilChanged()
            .compactMap { $0 }
            .filter { $0.count >= 2 }
            .map { Reactor.Action.setNamePrefix(nameStartsWith: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
            
    }
}

extension SearchCharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let characterInfoCell: MarvelCharacterInfoCell = collectionView.deque(for: indexPath)
        characterInfoCell.setCellModel(cellModels[indexPath.item])
        return characterInfoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - Constant.contentInset.left - Constant.contentInset.right - Constant.minimumLineSpacing) / 2
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = cellModels[indexPath.item]
        reactor?.action.onNext(.selectCharacter(cellModel.characterInfo))
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let itemsCount = cellModels.count
        if itemsCount == 0 { return }
        if indexPath.item >= itemsCount - 4 {
            reactor?.action.onNext(.fetchCharacters)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constant.minimumLineSpacing
    }
}
