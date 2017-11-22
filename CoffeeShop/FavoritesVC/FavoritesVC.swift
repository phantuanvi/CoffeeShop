//
//  FavoritesVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Kingfisher

class FavoritesVC: UIViewController {
    
    // MARK: create variables
    var titleNav: String = "Favorites"
    var productsArray = [Product]()
    
    let favoritesView = FavoritesView()
    
    // MARK: Lifecycle
    override func loadView() {
        view = favoritesView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = titleNav
        self.setNavigationBarItem()
        
        favoritesView.collectionView.delegate = self
        favoritesView.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStatusBarColor(UIBarStyle.blackTranslucent)
        productsArray = PTVDataService.sharedInstance.favoriteProducts
    }
}

extension FavoritesVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.titleLabel.text = productsArray[indexPath.row].name
        cell.detailLabel.text = productsArray[indexPath.row].description
        
        let resource: ImageResource = ImageResource(downloadURL: URL(string: productsArray[indexPath.row].urlPicture!)!)
        cell.productImageView.kf.setImage(with: resource)
        cell.costLabel.text = "$\(productsArray[indexPath.row].newCost)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width/2)-5 //some width
        let height = width * 1.5 //ratio
        return CGSize(width: width, height: height);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath)")
    }
}
