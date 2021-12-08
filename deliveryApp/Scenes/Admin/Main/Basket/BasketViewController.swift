//
//  BasketViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 7.12.21.
//

import UIKit

class BasketViewController: UIViewController {
    
    var coreDataService = CoreDataService()
    
    var dishesArray = [Dish]()
    var companysArray = [Company]()
    var deliverymansArray = [Deliveryman]()
    var deliverymansNSSet = NSSet()
    var deliverymansSet = Set<Deliveryman>()
    var selectedCompany: Company?
    var selectedDeliveryman: Deliveryman?

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var phoneTextFeild: UITextField!
    @IBOutlet private weak var adressTextFeild: UITextField!
    @IBOutlet private weak var dishPickerView: UIPickerView!
    @IBOutlet private weak var deliveryPickerView: UIPickerView!
    @IBOutlet private weak var orderIdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderIdLabel.text = String(Int.random(in: 1...10000))
        
        dishPickerView.dataSource = self
        dishPickerView.delegate = self
        deliveryPickerView.dataSource = self
        deliveryPickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.title = "Корзина"
        
        //dishesArray = CoreDataService.dishesArray
        dishesArray = coreDataService.getDishArray()
        companysArray = coreDataService.getCompanyArray()
    }
    
    @IBAction func pressedClearDishesButton(_ sender: UIButton) {
    }
    
    @IBAction func pressedAddOrderButtton(_ sender: UIButton) {
        if (nameTextField.text!.isEmpty || surnameTextField.text!.isEmpty || phoneTextFeild.text!.isEmpty || adressTextFeild.text!.isEmpty) {
            coreDataService.diplayAlertMessage(target: self, with: "Заполните все поля!", error: true)
            return
        }
        
        let result = coreDataService.createOrder(name: nameTextField.text!, surname: surnameTextField.text!, adress: adressTextFeild.text!, phone: phoneTextFeild.text!, deliveryman: selectedDeliveryman!, login: (CoreDataService.currentUser?.login)!, dishes: dishesArray, id: Int(orderIdLabel.text!)!)
        switch result {
        case true:
            coreDataService.diplayAlertMessage(target: self, with: "Успешно!", error: false)
        case false:
            coreDataService.diplayAlertMessage(target: self, with: "Ордер уже открыт", error: true)
        }
    }
    
    @IBAction func oressedNewNumberButton(_ sender: UIButton) {
        orderIdLabel.text = String(Int.random(in: 1...10000))
    }
    
}

//MARK: - UIPickerViewDataSource

extension BasketViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == dishPickerView {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dishPickerView {
            return dishesArray.count
        } else {
            switch component {
            case 0:
                return companysArray.count
            case 1:
                return deliverymansArray.count
            default:
                return 0
            }
        }
    }
}

//MARK: - UIPickerViewDelegate

extension BasketViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dishPickerView {
            let dish = dishesArray[row]
            return dish.name
        } else {
            switch component {
            case 0:
                let company = companysArray[row]
                return company.name
            case 1:
                return "\(deliverymansArray[row].name!) \(deliverymansArray[row].surname!)"
            default:
                return "error"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dishPickerView {
            return
        } else {
            switch component {
            case 0:
                let company = companysArray[row]
                deliverymansArray = Array(Set(_immutableCocoaSet: company.deliveryman!))
                selectedCompany = companysArray[row]
                pickerView.reloadComponent(1)
                pickerView.selectRow(0, inComponent: 1, animated: true)
            case 1:
                selectedDeliveryman = deliverymansArray[row]
            default:
                return
            }
        }
    }
}
