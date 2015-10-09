//
//  ViewController.swift
//  Jabil_Kiosk2.0
//
//  Created by Harrison Ferrone on 10/8/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class R_MainMenuViewController: UIViewController {

    @IBOutlet weak var sourceMediaTableView: UITableView!

    var externalWindow: ExternalWindow = ExternalWindow()
    var testItems = []
    var mediaArray: [Media]!
    var mediaLinkString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaArray = [Media]()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        checkForExistingScreen()
    }
    
    func checkForExistingScreen() {
        let screens = UIScreen.screens()
        
        if (screens.count > 1) {
            externalWindow.configureExternalWindowRootVC("OutputViewController")
        }
    }

    @IBAction func loadMediaOnButtonPressed(sender: AnyObject) {
        AdobeAPI.sharedInstance().loadMedia(didLoadMedia)
    }
    
    func didLoadMedia(mediaArray: [Media]) {
        self.mediaArray = mediaArray
        sourceMediaTableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "videoControlsSegueID" {
            let destination = segue.destinationViewController as! R_VideoControlsViewController
            destination.videoURL = NSURL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")!
            //destination.player = AVPlayer(URL: url!)
        }
    }
}

extension R_MainMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let outputCell = sourceMediaTableView.dequeueReusableCellWithIdentifier("outputCellID") as! MenuItemTableViewCell
        
        let media = mediaArray[indexPath.row]
        outputCell.titleLabel.text = media.menuItemText
        outputCell.subtitleLable.text = media.mediaType
        
        return outputCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellTapped = mediaArray[indexPath.row]
        mediaLinkString = cellTapped.menuItemLink
        NSNotificationCenter.defaultCenter().postNotificationName("menuCellTapped", object: self, userInfo: ["mediaLink": cellTapped.menuItemLink, "mediaType":cellTapped.mediaType])
        
        if (cellTapped.mediaType == "document") {
            performSegueWithIdentifier("documentControlsSegueID", sender: self)
        } else if (cellTapped.mediaType == "video") {
            performSegueWithIdentifier("videoControlsSegueID", sender: self)
        } else if (cellTapped.mediaType == "carousel") {
            performSegueWithIdentifier("carouselControlsSegueID", sender: self)
        }
    }
    
    
}
