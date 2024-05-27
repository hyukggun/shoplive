//
//  FavoriteCharactersViewController.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import ReactorKit
import RxSwift
import RxCocoa
import SnapKit
import UIKit

class FavoriteCharactersViewController<ComicsCharacter>: UIViewController,
                                                         View,
                                                         UICollectionViewDataSource,
                                                         UICollectionViewDelegateFlowLayout where ComicsCharacter: Decodable & Hashable & CharacterType {
    
    typealias Reactor = FavoriteCharactersReactor<ComicsCharacter>
    
    private enum Constant {
        static var minimumLineSpacing: CGFloat {
            10
        }
        static var contentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        }
    }
    
    private let titleLabel = UILabel()
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    private lazy var characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    private var cellModels: [CharacterInfoCellModel<ComicsCharacter>] = []
    
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setCharacterCollectionView()
    }
    
    private func setup() {
        titleLabel.text = "저장된 좋아하는 캐릭터가 없습니다"
        view.addSubview(titleLabel)
        view.addSubview(characterCollectionView)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        characterCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        characterCollectionView.contentInset = Constant.contentInset
    }
    
    private func setCharacterCollectionView() {
        characterCollectionView.register(CharacterInfoCell<ComicsCharacter>.self)
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
    }
    
    func bind(reactor: Reactor) {
        reactor.state.map { $0.cellModels }
            .asDriver(onErrorJustReturn: [])
            .drive(with: self) {
                $0.cellModels = $1
                $0.characterCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isFavoriteCharactersEmpty }
            .bind(to: characterCollectionView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { !$0.isFavoriteCharactersEmpty }
            .bind(to: titleLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let characterInfoCell: CharacterInfoCell<ComicsCharacter> = collectionView.deque(for: indexPath)
        characterInfoCell.setCellModel(cellModels[indexPath.item])
        return characterInfoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - Constant.contentInset.left - Constant.contentInset.right - Constant.minimumLineSpacing) / 2
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = cellModels[indexPath.item].characterInfo
        reactor?.action.onNext(.selectCharacter(selectedCharacter))
    }
}

typealias FavoriteMarvelCharactersViewController = FavoriteCharactersViewController<MarvelCharacter>

