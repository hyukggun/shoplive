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
    
    private let favCharactersVC = FavoriteMarvelCharactersViewController()
    
    private let favCharactersReactor = FavoriteMarvelCharactersReactor()
    
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setSearchCharactersViewController()
        setFavoriteCharactersViewController()
        viewControllers = [searchCharactersVC, favCharactersVC]
    }
    
    private func setSearchCharactersViewController() {
        searchCharactersVC.reactor = searchCharactersReactor
        searchCharactersVC.title = "캐릭터 검색"
        searchCharactersVC.tabBarItem = UITabBarItem(title: "Search Character", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        searchCharactersReactor.state.map { $0.selectedCharacters }
            .map { Array($0 )}
            .map { FavoriteCharactersReactor.Action.setFavoriteCharacters($0) }
            .bind(to: favCharactersReactor.action)
            .disposed(by: disposeBag)
    }
    
    private func setFavoriteCharactersViewController() {
        favCharactersVC.reactor = favCharactersReactor
        favCharactersVC.title = "좋아하는 캐릭터들"
        favCharactersVC.tabBarItem = UITabBarItem(title: "Favorite Characters", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        favCharactersReactor.state.compactMap { $0.selectedCharacter }
            .distinctUntilChanged()
            .map { SearchCharactersReactor.Action.selectCharacter($0) }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: searchCharactersReactor.action)
            .disposed(by: disposeBag)
    }
}
