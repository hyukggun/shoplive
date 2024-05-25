//
//  SearchCharactersViewController.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import SnapKit
import UIKit

class SearchCharactersViewController: UIViewController {
    
    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        titleLabel.text = "캐릭터 검색 화면"
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
