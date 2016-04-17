//
//  PromotionsTableViewCell.swift
//  AngelHack
//
//  Created by João Marcos on 17/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class PromotionsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPromotion: UIImageView!
    @IBOutlet weak var lblPromotion: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
