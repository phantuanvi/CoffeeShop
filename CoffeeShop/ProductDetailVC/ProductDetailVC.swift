//
//  ProductDetailVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import ZHDropDownMenu

class ProductDetailVC: UIViewController {
    
    let pickerValue = ["1", "2", "3", "4", "5"]
    
    let productDetailView = ProductDetailView()
    
    func placeOrderTapped() {
        print("placeOrderTapped")
    }
    
    func addToFavoriteTapped() {
        print("addToFavoriteTapped")
    }
    
    // Left Bar Button Item
    func leftBarButtonItem() {
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        leftButton.tintColor = UIColor.lightGray
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.addTarget(self, action: #selector(self.leftButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftButtonTapped(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // Right Bar Button Item
    func rightBarButtonItem() {
        
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "favorite")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        rightButton.tintColor = UIColor.red
        rightButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        rightButton.addTarget(self, action: #selector(self.leftButtonTapped), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    func rightButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Lifecycle
    override func loadView() {
        view = productDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = WHITE
        
        navigationItem.title = "ChocoLate Muffin"
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.gray]
        navigationController?.navigationBar.isTranslucent = true
        
        leftBarButtonItem()
        rightBarButtonItem()
        
        productDetailView.quantityMenu.delegate = self
        productDetailView.placeOrderButton.tap(placeOrderTapped)
        productDetailView.addToFavoriteButton.tap(addToFavoriteTapped)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStatusBarColor(UIBarStyle.default)
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
    }
    
    func dropDownMenu(_ menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }
}
