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
    var detailMenus = [Product]()
    var favoriteProducts = [Product]()
    var orderProducts = [OrderProduct]()
    
    func getMenusFromFirebase(complete: @escaping (Bool) -> ()) {
        print("getMenusFromFirebase: start")
        Database.database().reference().child("menus").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            // get menu value
            if snapshot.exists() {
                self.menusFromFirebase = snapshot.value as? [[String: String]]
                complete(true)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        print("getMenusFromFirebase: done")
    }
}
