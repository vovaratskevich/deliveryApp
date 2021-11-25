//
//  UIViewController+ViewModel.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 25.11.21.
//

import UIKit

private struct AssociatedKeys {
    static var viewModel = "viewModel"
}

protocol ViewModelAssociated where Self: UIViewController{
    associatedtype ViewModelType
    var viewModel: ViewModelType? { get set }
}

extension ViewModelAssociated{
    var viewModel: ViewModelType?{
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.viewModel) as? ViewModelType
        } set {
            if let value = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.viewModel, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

class AppViewController<ViewModelType>: UIViewController & ViewModelAssociated { }
class AppTableViewController<ViewModelType>: UITableViewController & ViewModelAssociated { }
class AppCollectionViewController<ViewModelType>: UICollectionViewController & ViewModelAssociated { }
