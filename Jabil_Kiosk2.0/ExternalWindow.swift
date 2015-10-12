//
//  ExternalWindow.swift
//  Jabil_Kiosk
//
//  Created by Harrison Ferrone on 10/5/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit

private var _sharedInstance = ExternalWindow()

class ExternalWindow: UIWindow {
    
    class func sharedInstance() -> ExternalWindow {
        return _sharedInstance
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    override init(frame: CGRect) {
        let screens = UIScreen.screens()
        let externalScreen = screens[1] as UIScreen
        super.init(frame: externalScreen.bounds)
        
        self.screen = externalScreen
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureExternalWindowRootVC(storyboardID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let outputVC = storyboard.instantiateViewControllerWithIdentifier(storyboardID)
        self.rootViewController = outputVC
        self.makeKeyAndVisible()
    }
    
    func clearExternalWindowVC() {
        self.rootViewController = nil
    }
}
