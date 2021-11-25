//
//  AuthViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 25.11.21.
//

import UIKit

class AuthViewController: AppViewController<AuthViewModel> {

    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func handlePressLoginButton(_ sender: Any) {
        //проверка соответсвия loginTextField & passTextField юзеру в базе
        
        //проверка роли юзера
        
        //если - юзер, ope nUserScene
        openUserScene()
        //если - админ, openAdminScene
        //openAdminScene()
    }
    
    func openUserScene() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let dishesListViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController") as? MainTabBarViewController else { return }
        navigationController?.pushViewController(dishesListViewController, animated: true)
    }
    
    func openAdminScene() {
        
    }
    
    func insertData() {
        //let user = User(context: viewModel?.coreDataService?.context)
    }

}
