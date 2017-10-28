//
//  FavoritesView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class FavoritesView: UIView {
    
    var flowLayout: UICollectionViewFlowLayout = {
        var flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return flow
    }()
    
    lazy var collectionView: UICollectionView = {
        var cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        cv.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
        cv.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1.0)
        return cv
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        render()
    }
    
    fileprivate func render() {
        sv(
            collectionView
        )
        
        collectionView.fillContainer()
    }
}
