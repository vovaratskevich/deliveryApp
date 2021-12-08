//
//  EditOrderViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 8.12.21.
//

import UIKit

class EditOrderViewController: UIViewController {
    
    var coreDataService = CoreDataService()
    var order = Order()

    @IBOutlet private weak var idTextFeild: UITextField!
    @IBOutlet private weak var statusTextFeild: UITextField!
    @IBOutlet private weak var nameTextFeild: UITextField!
    @IBOutlet private weak var surnameTextFeild: UITextField!
    @IBOutlet private weak var phoneTextFeild: UITextField!
    @IBOutlet private weak var adresTextFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        idTextFeild.text = String(order.id)
        statusTextFeild.text = order.status
        nameTextFeild.text = order.name
        surnameTextFeild.text = order.surname
        phoneTextFeild.text = order.phone
        adresTextFeild.text = order.adress
    }
    
    @IBAction func pressedSaveButton(_ sender: UIButton) {
        if (statusTextFeild.text!.isEmpty || nameTextFeild.text!.isEmpty || surnameTextFeild.text!.isEmpty || phoneTextFeild.text!.isEmpty || adresTextFeild.text!.isEmpty) {
            coreDataService.diplayAlertMessage(target: self, with: "Заполните все поля!", error: true)
            return
        }
        coreDataService.saveOrderData(id: Int(order.id), name: nameTextFeild.text!, surname: surnameTextFeild.text!, phone: phoneTextFeild.text!, adres: adresTextFeild.text!, status: statusTextFeild.text!)
        //coreDataService.diplayAlertMessage(target: self, with: "Успешно", error: false)
        let storyboard = UIStoryboard(name: "AdminMain", bundle: nil)
        guard let adminDishesListViewController = storyboard.instantiateViewController(withIdentifier: "AdminMainTabBarViewController") as? AdminMainTabBarViewController else { return }
        navigationController?.pushViewController(adminDishesListViewController, animated: true)
    }
}
