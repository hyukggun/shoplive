//
//  CharacterInfoCell.swift
//  marvel
//
//  Created by hyukmac on 5/24/24.
//

import NukeUI
import SnapKit
import UIKit

class CharacterInfoCell<ComicsCharacter>: UICollectionViewCell where ComicsCharacter: CharacterType {
    
    typealias CellModel = CharacterInfoCellModel<ComicsCharacter>
    
    private let container = UIView()
    
    private let characterImageView = LazyImageView()
    
    private let characterNameLabel = UILabel()
    
    private let characterDescriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        contentView.addSubview(container)
        contentView.cornerRadius(10)
            .borderWidth(1)
            .borderColor(.systemGray)
        contentView.clipsToBounds = true
        
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(characterImageView)
        
        let insetsForImage: CGFloat = 10
        characterImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(insetsForImage)
            $0.height.equalToSuperview().multipliedBy(0.65).inset(insetsForImage)
        }
        
        setCharacterNameLabel()
        setCharacterDescriptionLabel()
    }
    
    private func setCharacterNameLabel() {
        characterNameLabel.numberOfLines = 1
        characterNameLabel.textAlignment = .right
        container.addSubview(characterNameLabel)
        characterNameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(characterImageView.snp.bottom)
        }
    }
    
    private func setCharacterDescriptionLabel() {
        characterDescriptionLabel.numberOfLines = 3
        container.addSubview(characterDescriptionLabel)
        characterDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(characterNameLabel.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    func setCharacterInfo(_ character: ComicsCharacter) {
        characterNameLabel.text = character.name
        characterDescriptionLabel.text = character.description
        characterImageView.placeholderView = UIActivityIndicatorView()
        characterImageView.url = character.thumbnail.imageURL
    }
    
    func setCellModel(_ cellModel: CellModel) {
        characterNameLabel.text = cellModel.characterInfo.name
        characterDescriptionLabel.text = cellModel.characterInfo.description
        characterImageView.placeholderView = UIActivityIndicatorView()
        characterImageView.url = cellModel.characterInfo.thumbnail.imageURL
        contentView.backgroundColor = cellModel.isSelected ? .systemGray : .clear
    }
}

typealias MarvelCharacterInfoCell = CharacterInfoCell<MarvelCharacter>
