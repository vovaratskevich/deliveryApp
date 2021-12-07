//
//  AddIngridientViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 3.12.21.
//

import UIKit

class AddIngredientViewController: UIViewController {
    
    var coreDataService = CoreDataService()
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var countTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pressedAddButton(_ sender: UIButton) {
        if (nameTextField.text!.isEmpty || countTextField.text!.isEmpty) {
            coreDataService.diplayAlertMessage(target: self, with: "Заполните все поля!", error: true)
            return
        }
        
        let result = coreDataService.createIngredient(name: nameTextField.text!, count: countTextField.text!)
        switch result {
        case true:
            coreDataService.diplayAlertMessage(target: self, with: "Успешно!", error: false)
        case false:
            coreDataService.diplayAlertMessage(target: self, with: "Такой ингридиент уже существует", error: true)
        }
    }
    
}
