//
//  SettingsVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import QuickTableViewController

class SettingsVC: QuickTableViewController {

    var titleNav: String = "Settings"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = titleNav
        self.setNavigationBarItem()
        
        tableContents = [
            Section(title: "INFO", rows: [
                NavigationRow(title: "Name", subtitle: .rightAligned("TuanVi")),
                NavigationRow(title: "Title", subtitle: .rightAligned("developer")),
                NavigationRow(title: "Bio", subtitle: .rightAligned("I'm from Danang"))
            ]),
            Section(title: "ACCOUNT", rows: [
                NavigationRow(title: "Email", subtitle: .rightAligned("dev@phantuanvi.com")),
                NavigationRow(title: "Location", subtitle: .rightAligned("Danang"))
            ]),
            Section(title: "CONNECT", rows: [
                SwitchRow<SwitchCell>(title: "Facebook", switchValue: true, action: { _ in
                    print("Facebook switch")
                    
                }),
                SwitchRow<SwitchCell>(title: "Google", switchValue: true, action: { _ in
                    print("Google switch")
                })
            ])
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStatusBarColor(UIBarStyle.blackTranslucent)
    }

}
