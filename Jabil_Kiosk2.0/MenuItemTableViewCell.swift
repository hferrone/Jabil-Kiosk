//
//  MenuItemTableViewCell.swift
//  Jabil Kiosk
//
//  Created by Harrison Ferrone on 10/1/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clearColor()
        titleLabel.text?.uppercaseString
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
