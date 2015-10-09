//
//  RoundedButton.swift
//  Jabil Kiosk
//
//  Created by Harrison Ferrone on 9/30/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit

class BaseButton_Rounded: UIButton {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }

}
