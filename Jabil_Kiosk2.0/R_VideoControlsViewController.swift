//
//  R_VideoControlsViewController.swift
//  Jabil_Kiosk
//
//  Created by Harrison Ferrone on 10/6/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class R_VideoControlsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playOnButtonPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("playButtonTapped", object: self, userInfo: nil)
    }
    
    @IBAction func pauseOnButtonPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("pauseButtonTapped", object: self, userInfo: nil)
    }

}
