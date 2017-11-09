//
//  PTVDataService.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 11/2/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PTVDataService {
    static let sharedInstance = PTVDataService()
    
    var menusFromFirebase: [[String: String]]?
    var productsFromFirebase: [[String: String]]?
    var favoriteProducts = [Product]()
    var orderProducts = [OrderProduct]()
    
    func getMenusFromFirebase(complete: @escaping (Bool) -> ()) {
        Database.database().reference().child("menus").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            // get menu value
            if snapshot.exists() {
                self.menusFromFirebase = snapshot.value as? [[String: String]]
                complete(true)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getProductsFromFirebase(complete: @escaping (Bool) -> ()) {
        Database.database().reference().child("products").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            // get product value
            if snapshot.exists() {
                self.productsFromFirebase = snapshot.value as? [[String: String]]
                complete(true)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
