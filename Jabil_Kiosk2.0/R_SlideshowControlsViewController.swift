//
//  R_SlideshowControlsViewController.swift
//  Jabil_Kiosk
//
//  Created by Harrison Ferrone on 10/5/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit

class R_SlideshowControlsViewController: UIViewController {

    @IBOutlet weak var leftCarouselButton: UIButton!
    @IBOutlet weak var rightCarouselButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableSlideshowButtons()
        registerObservers()
        // Do any additional setup after loading the view.
    }
    
    func registerObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enableSlideShowButtons:", name: "imagesLoaded", object: nil)
    }
    
    func disableSlideshowButtons() {
        leftCarouselButton.enabled = false
        rightCarouselButton.enabled = false
    }
    
    func enableSlideShowButtons(notification: NSNotification) {
        leftCarouselButton.enabled = true
        rightCarouselButton.enabled = true
    }
    
    @IBAction func moveSlideshowIndexLeft(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("leftSlideClicked", object: self, userInfo: nil)
    }
    
    @IBAction func moveSlideshowIndexRight(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("rightSlideClicked", object: self, userInfo: nil)
    }
}
