//
//  R_SlideshowControlsViewController.swift
//  Jabil_Kiosk
//
//  Created by Harrison Ferrone on 10/5/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit

class R_SlideshowControlsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveSlideshowIndexLeft(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("leftSlideClicked", object: self, userInfo: nil)
    }
    
    @IBAction func moveSlideshowIndexRight(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("rightSlideClicked", object: self, userInfo: nil)
    }
}
