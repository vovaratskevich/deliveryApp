//
//  RegistrationViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 2.12.21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    var coreDataService = CoreDataService()
    var user: User?

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = coreDataService.obtainMainUser()
    }
    
    @IBAction func pressedSignInButton(_ sender: UIButton) {
        if (loginTextField.text!.isEmpty ||
            emailTextField.text!.isEmpty ||
            nameTextField.text!.isEmpty ||
            surnameTextField.text!.isEmpty ||
            phoneTextField.text!.isEmpty ||
            passwordTextField.text!.isEmpty) {
            coreDataService.diplayAlertMessage(target: self, with: "Заполните все поля", error: true)
            return
        }
        let result = coreDataService.createUser(login: loginTextField.text!, email: emailTextField.text!, name: nameTextField.text!, surname: surnameTextField.text!, phone: phoneTextField.text!, password: passwordTextField.text!)
        switch result {
        case true:
            coreDataService.diplayAlertMessage(target: self, with: "Успешно!", error: false)
        case false:
            coreDataService.diplayAlertMessage(target: self, with: "Пользователь с таким логином уже существует", error: true)
        }
    }
    
    func openLoginView() {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let adminDishesListViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        navigationController?.pushViewController(adminDishesListViewController, animated: true)
    }
}
