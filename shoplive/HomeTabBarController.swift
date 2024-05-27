//
//  HomeTabBarController.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import RxCocoa
import RxSwift
import UIKit

class HomeTabBarController: UITabBarController {
    
    private let searchCharactersVC = SearchCharactersViewController()
    
    private let searchCharactersReactor = SearchCharactersReactor<MarvelCharacter>()
    
    private let favCharactersVC = FavoriteCharactersViewController()
    
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setSearchCharactersViewController()
        setFavoriteCharactersVieController()
        viewControllers = [searchCharactersVC, favCharactersVC]
    }
    
    private func setSearchCharactersViewController() {
        searchCharactersVC.reactor = searchCharactersReactor
        searchCharactersVC.title = "캐릭터 검색"
        searchCharactersVC.tabBarItem = UITabBarItem(title: "Search Character", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
    }
    
    private func setFavoriteCharactersVieController() {
        favCharactersVC.tabBarItem = UITabBarItem(title: "Favorite Characters", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
    }
}
