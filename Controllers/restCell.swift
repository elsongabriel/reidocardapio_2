//
//  restCell.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 25/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit

class restCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var restName: UILabel!
    @IBOutlet var restCat: UILabel!
    @IBOutlet var restInfo: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
