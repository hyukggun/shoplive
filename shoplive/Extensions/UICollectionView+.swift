//
//  UICollectionView+.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import UIKit

extension UICollectionView {
    func register<C: UICollectionViewCell>(_ cell: C.Type) {
        register(C.self, forCellWithReuseIdentifier: C.cellIdentifier)
    }
    
    func deque<C: UICollectionViewCell>(for indexPath: IndexPath) -> C {
        guard let cell = dequeueReusableCell(withReuseIdentifier: C.cellIdentifier, for: indexPath) as? C else {
            fatalError("deque reusable cell failed : \(C.cellIdentifier)")
        }
        return cell
    }
}

