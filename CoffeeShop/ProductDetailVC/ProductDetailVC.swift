//
//  ProductDetailVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import ZHDropDownMenu
import Kingfisher

class ProductDetailVC: UIViewController {
    
    // MARK: create variables
    let pickerValue = ["1", "2", "3", "4", "5"]
    var product: Product? = nil
    
    let productDetailView = ProductDetailView()
    
    //MARK: Lifecycle
    override func loadView() {
        view = productDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = WHITE
        
        navigationItem.title = "ChocoLate Muffin"
        
        leftBarButtonItem()
        
        productDetailView.quantityMenu.delegate = self
        productDetailView.placeOrderButton.tap(placeOrderTapped)
        productDetailView.addToFavoriteButton.tap(addToFavoriteTapped)
        
        let resource: ImageResource = ImageResource(downloadURL: URL(string: self.product!.urlPicture!)!)
        productDetailView.productImageView.kf.setImage(with: resource)
        productDetailView.descriptionTextView.text = product?.description
        productDetailView.costLabel.text = "$\(product!.newCost)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.gray]
        navigationController?.navigationBar.isTranslucent = true
        setStatusBarColor(UIBarStyle.default)
    }
    
    // MARK: create functions
    private func placeOrderTapped() {
        print("placeOrderTapped")
        let orderSummaryVC = OrderSummaryVC()
        navigationController?.pushViewController(orderSummaryVC, animated: true)
    }
    
    private func addToFavoriteTapped() {
        print("add to favorite")
        var  message: String = ""
        if !product!.isFavorite {
            product!.isFavorite = true
            PTVDataService.sharedInstance.favoriteProducts.append(product!)
            message = "Add to favorite success"
        } else {
            message = "Product was favorited"
        }
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func leftButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // Left Bar Button Item
    private func leftBarButtonItem() {
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        leftButton.tintColor = UIColor.lightGray
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.addTarget(self, action: #selector(self.leftButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
}

extension ProductDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValue.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValue[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(pickerValue[row])")
    }
}

extension ProductDetailVC: ZHDropDownMenuDelegate {
    func dropDownMenu(_ menu: ZHDropDownMenu!, didChoose index: Int) {
        print("\(menu) choosed at index \(index)")
        let totalCost = (index + 1) * product!.newCost
        productDetailView.costLabel.text = "$\(totalCost)"
    }
    
    func dropDownMenu(_ menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }
}
