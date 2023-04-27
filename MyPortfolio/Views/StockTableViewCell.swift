//
//  StockTableViewCell.swift
//  MyStocks
//
//  Created by Naveen Ramachandrappa on 4/24/23.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tickerLabel: UILabel!
    
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
