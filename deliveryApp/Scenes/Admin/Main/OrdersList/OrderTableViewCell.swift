//
//  OrderTableViewCell.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 8.12.21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var dish: Dish?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func pressedAddButton(_ sender: Any) {
        //CoreDataService.dishesArray.insert(dish!, at: 0)
        //print(CoreDataService.dishesArray)
    }
    
}
