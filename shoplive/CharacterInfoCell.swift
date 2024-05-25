//
//  CharacterInfoCell.swift
//  marvel
//
//  Created by hyukmac on 5/24/24.
//
import SnapKit
import UIKit

class CharacterInfoCell: UICollectionViewCell {
    
    private let container = UIView()
    
    private let characterImageView = UIImageView()
    
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
        
        characterImageView.backgroundColor = .systemPink
        characterNameLabel.text = "캐릭터 이름"
        characterDescriptionLabel.text = "캐릭터 설명입니다."
        
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
}
