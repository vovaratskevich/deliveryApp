//
//  ProfileViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 2.12.21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var coreDataService = CoreDataService()
    let currentUser = CoreDataService.currentUser
    
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var roleTextField: UITextField!
    @IBOutlet private weak var editButton: UIBarButtonItem!
    @IBOutlet private weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.navigationItem.title = "Профиль"
    }
    
    @IBAction func pressedEditButton(_ sender: UIBarButtonItem) {
        loginTextField.isUserInteractionEnabled = true
        emailTextField.isUserInteractionEnabled = true
        nameTextField.isUserInteractionEnabled = true
        surnameTextField.isUserInteractionEnabled = true
        phoneTextField.isUserInteractionEnabled = true
        roleTextField.isUserInteractionEnabled = true
        saveButton.isEnabled = true
    }
    
    @IBAction func pressedSaveButton(_ sender: UIButton) {
        loginTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        nameTextField.isUserInteractionEnabled = false
        surnameTextField.isUserInteractionEnabled = false
        phoneTextField.isUserInteractionEnabled = false
        roleTextField.isUserInteractionEnabled = false
        saveButton.isEnabled = false
        
        //save changes at coreData
    }
    @IBAction func pressedLogoutButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let adminDishesListViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        navigationController?.pushViewController(adminDishesListViewController, animated: true)
    }
    
    func setupView() {
        loginTextField.text = currentUser?.login
        emailTextField.text = currentUser?.email
        nameTextField.text = currentUser?.name
        surnameTextField.text = currentUser?.surname
        phoneTextField.text = currentUser?.phone
        roleTextField.text = currentUser?.accessory
    }

}
