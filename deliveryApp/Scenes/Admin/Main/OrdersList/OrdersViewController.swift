//
//  OrdersViewController.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 7.12.21.
//

import UIKit
import CoreData

class OrdersViewController: UIViewController {
    
    private var coreDataService = CoreDataService()
    private var orderFetchResultController: NSFetchedResultsController<Order>!

    @IBOutlet private weak var orderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        orderTableView.delegate = self
        orderTableView.dataSource = self
        
        coreDataService.getOrderFetchResultController()
        orderFetchResultController = coreDataService.orderFetchResultController
        
        orderFetchResultController.delegate = self
        
        try! orderFetchResultController.performFetch()
        
        orderTableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.title = "Заказы"
        
        coreDataService.getOrderFetchResultController()
        orderFetchResultController = coreDataService.orderFetchResultController
        try! orderFetchResultController.performFetch()
        orderTableView.reloadData()
    }
}

extension OrdersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = coreDataService.orderFetchResultController.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        let order = coreDataService.orderFetchResultController.object(at: indexPath)
        
        cell.textLabel?.text = String(order.id)
        cell.detailTextLabel?.text = order.deliveryman?.name
        return cell
    }    
}

extension OrdersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orderTableView.reloadData()
        let storyboard = UIStoryboard(name: "AdminMain", bundle: nil)
        guard let editOrderViewController = storyboard.instantiateViewController(withIdentifier: "EditOrderViewController") as? EditOrderViewController else { return }
        let order = coreDataService.orderFetchResultController.object(at: indexPath)
        editOrderViewController.order = order
        navigationController?.pushViewController(editOrderViewController, animated: true)
        viewWillDisappear(true)
    }
}

//MARK: - NSFetchedResultsControllerDelegate

extension OrdersViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if indexPath != nil {
                orderTableView.insertRows(at: [indexPath!], with: .automatic)
                try! orderFetchResultController.performFetch()
                orderTableView.reloadData()
            }
        case .delete:
            orderTableView.deleteRows(at: [indexPath!], with: .middle)
        default:
            break
        }
    }
}
