//
//  AddDishViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 3.12.21.
//

import UIKit

class AddDishViewController: UIViewController {
    
    var coreDataService = CoreDataService()
    var ingredientsArray = [Ingredient]()
    var chosenIngredientsArray = [Ingredient]()
    
    @IBOutlet private weak var nameTextFeild: UITextField!
    @IBOutlet private weak var priceTextField: UITextField!
    @IBOutlet private weak var ingredientPickerView: UIPickerView!
    @IBOutlet private weak var ingredientCount: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsArray = coreDataService.getIngredientArray()

        ingredientPickerView.dataSource = self
        ingredientPickerView.delegate = self
    }
    
    @IBAction func pressedAddIngredientButton(_ sender: UIButton) {
        
        let chosenIngredient = ingredientsArray[ingredientPickerView.selectedRow(inComponent: 0)]
        chosenIngredientsArray.append(chosenIngredient)
        
        let count = Set(chosenIngredientsArray).count
        ingredientCount.text = String(count)
        
    }

    @IBAction func pressedAddDishButton(_ sender: UIButton) {
        if (nameTextFeild.text!.isEmpty || priceTextField.text!.isEmpty) {
            coreDataService.diplayAlertMessage(target: self, with: "Заполните все поля!", error: true)
            return
        }
        
        let result = coreDataService.createDish(name: nameTextFeild.text!, price: priceTextField.text!, ingredients: ingredientsArray)
        switch result {
        case true:
            coreDataService.diplayAlertMessage(target: self, with: "Успешно!", error: false)
        case false:
            coreDataService.diplayAlertMessage(target: self, with: "Такое блюдо уже существует", error: true)
        }
        
        coreDataService.getFetchDishResultController()
        try! coreDataService.fetchDishResultController.performFetch()
    }
}

//MARK: - UIPickerViewDataSource
 
extension AddDishViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ingredientsArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension AddDishViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let ingredient = ingredientsArray[row]
        return ingredient.name
    }
}
