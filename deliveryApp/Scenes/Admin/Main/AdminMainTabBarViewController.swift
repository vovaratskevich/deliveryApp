//
//  AdminMainViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 30.11.21.
//

import UIKit

class AdminMainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        //self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
