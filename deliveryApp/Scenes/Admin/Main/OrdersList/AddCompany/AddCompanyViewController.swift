//
//  AddCompanyViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 6.12.21.
//

import UIKit

class AddCompanyViewController: UIViewController {
    
    var coreDataService = CoreDataService()
    var deliverymansArray = [Deliveryman]()
    var chosenDeliverymansArray = [Deliveryman]()

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var adressTextField: UITextField!
    @IBOutlet private weak var phoneTextFeild: UITextField!
    @IBOutlet private weak var zipTextField: UITextField!
    @IBOutlet private weak var deliverymanPickerView: UIPickerView!
    @IBOutlet private weak var countTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deliverymansArray = coreDataService.getDeliverymanArray()
        
        deliverymanPickerView.dataSource = self
        deliverymanPickerView.delegate = self
    }
    
    @IBAction func pressedAddDeliverymanButton(_ sender: UIButton) {
        
        let chosenDeliveryman = deliverymansArray[deliverymanPickerView.selectedRow(inComponent: 0)]
        chosenDeliverymansArray.append(chosenDeliveryman)
        
        let count = Set(chosenDeliverymansArray).count
        countTextField.text = String(count)
    }
    
    @IBAction func pressedAddCompanyButton(_ sender: UIButton) {
        if (nameTextField.text!.isEmpty || adressTextField.text!.isEmpty ||  phoneTextFeild.text!.isEmpty || zipTextField.text!.isEmpty) {
            coreDataService.diplayAlertMessage(target: self, with: "Заполните все поля!", error: true)
            return
        }
        
        let result = coreDataService.createCompany(name: nameTextField.text!, deliverymans: deliverymansArray)
        switch result {
        case true:
            coreDataService.diplayAlertMessage(target: self, with: "Успешно!", error: false)
        case false:
            coreDataService.diplayAlertMessage(target: self, with: "Такая компания уже существует", error: true)
        }
        
        coreDataService.getFetchDishResultController()
        try! coreDataService.fetchDishResultController.performFetch()
    }
}

//MARK: - UIPickerViewDataSource
 
extension AddCompanyViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return deliverymansArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension AddCompanyViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let deliveryman = deliverymansArray[row]
        return "\(deliveryman.name!) \(deliveryman.surname!)"
    }
}
