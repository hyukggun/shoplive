//
//  FavoriteCharactersViewController.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import SnapKit
import UIKit

class FavoriteCharactersViewController: UIViewController {
    
    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        titleLabel.text = "좋아하는 캐릭터 모음 화면"
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
