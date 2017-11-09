//
//  Product.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 11/2/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import Foundation

struct Product {
    let name: String
    let description: String
    let newCost: Int
    let oldCost: Int?
    let urlPicture: String?
    var isFavorite: Bool = false
    var quantity: Int
}
