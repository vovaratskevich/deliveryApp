//
//  AddDeliverymanViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 6.12.21.
//

import UIKit

class AddDeliverymanViewController: UIViewController {
    
    var coreDataService = CoreDataService()
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextFeild: UITextField!
    @IBOutlet private weak var phoneTextFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    } 

    @IBAction func pressedAddButton(_ sender: UIButton) {
        if (nameTextField.text!.isEmpty || surnameTextFeild.text!.isEmpty || phoneTextFeild.text!.isEmpty) {
            coreDataService.diplayAlertMessage(target: self, with: "Заполните все поля!", error: true)
            return
        }
        
        let result = coreDataService.createDeliveryman(name: nameTextField.text!, surname: surnameTextFeild.text!, phone: phoneTextFeild.text!)
        switch result {
        case true:
            coreDataService.diplayAlertMessage(target: self, with: "Успешно!", error: false)
        case false:
            coreDataService.diplayAlertMessage(target: self, with: "Такой курьер уже существует", error: true)
        }
    }
}
