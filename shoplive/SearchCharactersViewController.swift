//
//  SearchCharactersViewController.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import SnapKit
import UIKit

class SearchCharactersViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setCharacterCollectionView()
    }
    
    private func setup() {
        view.addSubview(characterCollectionView)
        view.addSubview(searchCharcterBar)
        
        searchCharcterBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        characterCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchCharcterBar.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        characterCollectionView.contentInset = Constant.contentInset
    }
    
    private func setCharacterCollectionView() {
        characterCollectionView.register(CharacterInfoCell.self)
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
    }
}

extension SearchCharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let characterInfoCell: CharacterInfoCell = collectionView.deque(for: indexPath)
        return characterInfoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - Constant.contentInset.left - Constant.contentInset.right - Constant.minimumLineSpacing) / 2
        let cellHeight = collectionView.bounds.height * 0.33
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constant.minimumLineSpacing
    }
}

