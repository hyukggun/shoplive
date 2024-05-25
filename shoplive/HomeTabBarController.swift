//
//  HomeTabBarController.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let searchCharacterVC = SearchCharactersViewController()
        searchCharacterVC.title = "캐릭터 검색"
        searchCharacterVC.tabBarItem = UITabBarItem(title: "Search Character", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let favCharacterVC = FavoriteCharactersViewController()
        favCharacterVC.title = "좋아하는 캐릭터들"
        favCharacterVC.tabBarItem = UITabBarItem(title: "Favorite Characters", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        viewControllers = [searchCharacterVC, favCharacterVC]
    }
}
