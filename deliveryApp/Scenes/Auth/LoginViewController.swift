//
//  AuthViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 25.11.21.
//

import UIKit

class LoginViewController: AppViewController<AuthViewModel> {
    
    var coreDataService = CoreDataService()
    var user: User?

    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = coreDataService.obtainMainUser()
    }
    @IBAction func handlePressLoginButton(_ sender: Any) {
        //проверка соответсвия loginTextField & passTextField юзеру в базе
        if (loginTextField.text!.isEmpty || passwordTextField.text!.isEmpty) {
            coreDataService.diplayAlertMessage(target: self, with: "Заполните все поля", error: true)
            return
        }
        user = coreDataService.fetchUser(login: loginTextField.text!)
        
        //проверка роли юзера
        
        //если - юзер, openUserScene
        //openUserScene()
        //если - админ, openAdminScene
        let pass = user?.password
        if let user = user, pass == passwordTextField.text {
            CoreDataService.currentUser = user
            openAdminScene(with: user)
        } else if let _ = user {
            coreDataService.diplayAlertMessage(target: self, with: "Неверный пароль!", error: true)
            return
        } else {
            coreDataService.diplayAlertMessage(target: self, with: "Такого пользователя не существует!", error: true)
        }
    }
    
    func openUserScene(with user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let dishesListViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController") as? MainTabBarViewController else { return }
        navigationController?.pushViewController(dishesListViewController, animated: true)
    }
    
    func openAdminScene(with user: User) {
        let storyboard = UIStoryboard(name: "AdminMain", bundle: nil)
        guard let adminDishesListViewController = storyboard.instantiateViewController(withIdentifier: "AdminMainTabBarViewController") as? AdminMainTabBarViewController else { return }
        navigationController?.pushViewController(adminDishesListViewController, animated: true)
    }
    
    func insertData() {
        //let user = User(context: viewModel?.coreDataService?.context)
    }

}
