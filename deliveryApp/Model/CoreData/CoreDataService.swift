//
//  CoreDataService.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 23.11.21.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    
    static var currentUser: User?
    static var dishesArray: [Dish]?
    
    var fetchDishResultController = NSFetchedResultsController<Dish>()
    var fetchCompanyResultController = NSFetchedResultsController<Company>()
    var orderFetchResultController = NSFetchedResultsController<Order>()
    
    var context: NSManagedObjectContext    {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "deliveryApp")
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Unable to load persistent stores: \(error)")
                }
            }
            return container
    }()
    
    func saveIfContextHasChanges() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchUser(login: String) -> User? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "login = %@", login)
        
        if let users = try? context.fetch(fetchRequest) as? [User], !users.isEmpty {
            return users.first!
        } else {
            return nil
        }
    }
    
    func createUser(login: String, email: String, name: String, surname: String, phone: String, password: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "login == %@", login)
        
        if let users = try? context.fetch(fetchRequest) as? [User], !users.isEmpty {
            return false
        } else {
            let user = User(context: context)
            user.accessory = "user"
            user.email = email
            user.name = name
            user.surname = surname
            user.phone = phone
            user.login = login
            user.password = password
            saveContext()
            return true
        }
        
    }
    
    //MARK: - Dish
    
    func createDish(name: String, price: String, ingredients: [Ingredient]) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        if let dishes = try? context.fetch(fetchRequest) as? [Dish], !dishes.isEmpty {
            return false
        } else {
            let dish = Dish(context: context)
            dish.name = name
            dish.price = price
            dish.ingridients = NSSet(array: ingredients)
            saveContext()
            return true
        }
    }
    
    func getDishArray() -> [Dish] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        
        if let dishs = try? context.fetch(fetchRequest) as? [Dish], !dishs.isEmpty {
            return dishs
        } else {
            return [Dish]()
        }
    }
    
    func getFetchDishResultController() {
        
        let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchDishResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        try! fetchDishResultController.performFetch()
    }
    
    func deleteDish(dish: Dish) {
        context.delete(dish)
        saveContext()
    }
    
    //MARK: - Ingredient
    
    func createIngredient(name: String, count: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        if let ingredients = try? context.fetch(fetchRequest) as? [Ingredient], !ingredients.isEmpty {
            return false
        } else {
            let ingredient = Ingredient(context: context)
            ingredient.name = name
            ingredient.count = Int16(count)!
            saveContext()
            return true
        }
    }
    
    func fetchIngredient(name: String) -> Ingredient? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        if let ingredients = try? context.fetch(fetchRequest) as? [Ingredient], !ingredients.isEmpty {
            return ingredients.first!
        } else {
            return nil
        }
    }
    
    func getIngredientsCount() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch {
            return 0
        }
    }
    
    func getIngredientArray() -> [Ingredient] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        
        if let ingredients = try? context.fetch(fetchRequest) as? [Ingredient], !ingredients.isEmpty {
            return ingredients
        } else {
            return [Ingredient]()
        }
    }
    
    //MARK: - Deliveryman
    
    func createDeliveryman(name: String, surname: String, phone: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Deliveryman")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        if let deliverymans = try? context.fetch(fetchRequest) as? [Deliveryman], !deliverymans.isEmpty {
            return false
        } else {
            let deliveryman = Deliveryman(context: context)
            deliveryman.name = name
            deliveryman.surname = surname
            deliveryman.phone = phone
            saveContext()
            return true
        }
    }
    
    func fetchDeliveryman(name: String) -> Deliveryman? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Deliveryman")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        if let deliverymans = try? context.fetch(fetchRequest) as? [Deliveryman], !deliverymans.isEmpty {
            return deliverymans.first!
        } else {
            return nil
        }
    }
    
    func getDeliverymansCount() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Deliveryman")
        
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch {
            return 0
        }
    }
    
    func getDeliverymanArray() -> [Deliveryman] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Deliveryman")
        
        if let deliverymans = try? context.fetch(fetchRequest) as? [Deliveryman], !deliverymans.isEmpty {
            return deliverymans
        } else {
            return [Deliveryman]()
        }
    }
    
    //MARK: - Company
    
    func createCompany(name: String, deliverymans: [Deliveryman]) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        if let companys = try? context.fetch(fetchRequest) as? [Company], !companys.isEmpty {
            return false
        } else {
            let company = Company(context: context)
            company.name = name
            company.deliveryman = NSSet(array: deliverymans)
            saveContext()
            return true
        }
    }
    
    func getCompanyArray() -> [Company] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        
        if let companys = try? context.fetch(fetchRequest) as? [Company], !companys.isEmpty {
            return companys
        } else {
            return [Company]()
        }
    }
    
    func getFetchCompanyResultController() {
        
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchCompanyResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        try! fetchDishResultController.performFetch()
    }
    
    func deleteDish(dish: Company) {
        context.delete(dish)
        saveContext()
    }
    
    //MARK: - Order
    
    func createOrder(name: String, surname: String, adress: String, phone: String, deliveryman: Deliveryman, login: String, dishes: [Dish], id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        if let orders = try? context.fetch(fetchRequest) as? [Order], !orders.isEmpty {
            return false
        } else {
            let order = Order(context: context)
            order.adress = adress
            order.deliveryman = deliveryman
            order.dish = NSSet(array: dishes)
            order.login = login
            order.name = name
            order.surname = surname
            order.id = Int16(id)
            order.status = "pending"
            
            let date = Date()
            order.date = date
            
            let user = fetchUser(login: (CoreDataService.currentUser?.login)!)
            order.owner = user
            saveContext()
            return true
        }
    }
    
    func getOrderFetchResultController() {
        
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Order.date), ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        orderFetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        try! orderFetchResultController.performFetch()
    }
    
    //MARK: - CreateAdmin
    
    func obtainMainUser() -> User {
        let login = "stanyn"
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "login == %@", login)
        
        if let users = try? context.fetch(fetchRequest) as? [User], !users.isEmpty {
            return users.first!
        } else {
            let user = User(context: context)
            user.accessory = "admin"
            user.email = "emal@mail.com"
            user.name = "Stas"
            user.surname = "Petsevich"
            user.phone = "+(375)33-859-36-28"
            user.login = login
            user.password = "1111"
            saveContext()
            return user
        }
    }
    
    //MARK: - DisplayAlertMessage
    
    func diplayAlertMessage(target: UIViewController, with message: String, error: Bool ) {
        enum AlertTitle: String {
            case Error = "Ошибка"
            case Succes = "Внимание"
        }
        
        let title: AlertTitle
        
        switch error {
        case true:
            title = .Error
        case false:
            title = .Succes
        }
        
        let alert = UIAlertController(title: title.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        target.present(alert, animated: true, completion: nil)
    }
    
}
