//
//  O_SlideshowViewController.swift
//  Jabil_Kiosk
//
//  Created by Harrison Ferrone on 10/5/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class O_SlideshowViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var outputContainerView: UIView!
    
    var baseURL = "http://104.196.26.10:4503"
    var mediaType = ""
    var mediaLink = ""

    var youtubePlayer: YTPlayerView = YTPlayerView()
    var videoURL = String()

    var photosArray : [UIImage] = []
    var carouselImageView: UIImageView?
    var itemIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllObservers()
    }
    
    func registerAllObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cellTapped:", name: "menuCellTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "clickLeftOnSlideshow:", name: "leftSlideClicked", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "clickRightOnSlideshow:", name: "rightSlideClicked", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playVideo:", name: "playButtonTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pauseVideo:", name: "pauseButtonTapped", object: nil)
    }
    
    func cellTapped(notification: NSNotification) {
        if let userInfo: Dictionary<String, String!> = notification.userInfo as? Dictionary<String, String!> {
            mediaType = userInfo["mediaType"]!
            mediaLink = userInfo["mediaLink"]!
            loadOutputContent(mediaType)
        }
    }
    
    func clickLeftOnSlideshow(notification: NSNotification) {
        if itemIndex != 0 {
            changeCarouselPicture(itemIndex--)
        } else if itemIndex == 0 {
            itemIndex = photosArray.count - 1
            changeCarouselPicture(itemIndex)
        }
    }
    
    func clickRightOnSlideshow(notification: NSNotification) {
        if itemIndex != photosArray.count - 1 {
            changeCarouselPicture(itemIndex++)
        } else if itemIndex == photosArray.count - 1 {
            itemIndex = 0
            changeCarouselPicture(itemIndex)
        }
    }
    
    func loadOutputContent(mediaType: String) {
        switch mediaType {
            case "document":
                loadDocument()
            case "video":
                retrieveVideoURLFromAPI()
            case "carousel":
                loadCarousel()
            default:
                break
        }
    }
    
    func loadDocument() {
        let url = NSURL(string: "\(baseURL)\(mediaLink)")
        let urlRequest = NSURLRequest(URL: url!)
        let documentWebView = UIWebView(frame: self.outputContainerView.bounds)
        documentWebView.loadRequest(urlRequest)
        self.outputContainerView.addSubview(documentWebView)
    }
    
    func retrieveVideoURLFromAPI() {
        AdobeAPI.sharedInstance().getMediaLink(mediaLink) { (arrayFromAPI) -> Void in
            if let mediaArray = arrayFromAPI {
                print(mediaArray)
                self.videoURL = mediaArray[0] as! String
                self.loadVideoPlayer()
            }
        }
    }
    
    func loadVideoPlayer() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.youtubePlayer.frame = self.view.bounds
            self.view.addSubview(self.youtubePlayer)
            print(self.videoURL)
            self.youtubePlayer.loadWithVideoId(self.videoURL)
        }
        
        //        let player = AVPlayer(URL: videoURL)
        //        let playerLayer = AVPlayerLayer(player: player)
        //        playerLayer.frame = self.view.frame
        //        self.view.layer.addSublayer(playerLayer)
        //        player.play()
    }
    
    func playVideo(notification: NSNotification) {
        youtubePlayer.playVideo()
    }
    
    func pauseVideo(notification: NSNotification) {
        youtubePlayer.pauseVideo()
    }
    
    func loadCarousel() {
        carouselImageView = UIImageView(frame: outputContainerView.bounds)
        carouselImageView!.contentMode = UIViewContentMode.ScaleAspectFit
        self.outputContainerView.addSubview(carouselImageView!)
        
        returnCarouselImageArray()
    }
    
    func returnCarouselImageArray() {
        AdobeAPI.sharedInstance().getMediaLink("\(mediaLink).content.json") { (returnedPhotosArray) -> Void in
            if let photoLinks = returnedPhotosArray {
                print(photoLinks)
                for imageLink in photoLinks {
                    let imageURL = NSURL(string: "\(self.baseURL)\(imageLink)")
                    print(imageURL)
                    if let imageData = NSData(contentsOfURL: imageURL!) {
                        let image = UIImage(data: imageData)
                        self.photosArray.append(image!)
                    }
                    print(self.photosArray)
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.changeCarouselPicture(self.itemIndex)
                    NSNotificationCenter.defaultCenter().postNotificationName("imagesLoaded", object: self)
                })
            }
        }
    }
    
    func changeCarouselPicture(index: Int) {
        carouselImageView?.image = photosArray[itemIndex]
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
