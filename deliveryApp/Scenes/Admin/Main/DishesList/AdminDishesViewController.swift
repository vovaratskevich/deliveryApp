//
//  AdminDishesViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 2.12.21.
//

import UIKit
import CoreData

class AdminDishesViewController: UIViewController {

    var coreDataService = CoreDataService()
    var fethDishResultController: NSFetchedResultsController<Dish>!
    
    @IBOutlet private weak var dishTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        dishTableView.dataSource = self
        dishTableView.delegate = self
        
        coreDataService.getFetchDishResultController()
        fethDishResultController = coreDataService.fetchDishResultController
        
        fethDishResultController.delegate = self
        
        try! fethDishResultController.performFetch()
        
        dishTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        try! fethDishResultController.performFetch()
        dishTableView.reloadData()
    }
    
    @IBAction func reloadData(_ sender: Any) {
        try! fethDishResultController.performFetch()
        dishTableView.reloadData()
    }
    
}

//MARK: - UITableViewDataSource

extension AdminDishesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = coreDataService.fetchDishResultController.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishTableViewCell", for: indexPath)
        
        let dish = coreDataService.fetchDishResultController.object(at: indexPath)
        
        cell.textLabel?.text = dish.name
        cell.detailTextLabel?.text = dish.price
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension AdminDishesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dish = fethDishResultController.object(at: indexPath)
            coreDataService.deleteDish(dish: dish)
        }
    }
}

//MARK: - UITableViewDelegate

extension AdminDishesViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if indexPath != nil {
                dishTableView.insertRows(at: [indexPath!], with: .automatic)
                try! fethDishResultController.performFetch()
                dishTableView.reloadData()
            }
        case .delete:
            dishTableView.deleteRows(at: [indexPath!], with: .middle)
        default:
            break
        }
    }
}
