//
//  ExternalWindow.swift
//  Jabil_Kiosk
//
//  Created by Harrison Ferrone on 10/5/15.
//  Copyright © 2015 Harrison Ferrone. All rights reserved.
//

import UIKit

class ExternalWindow: UIWindow {

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
        if storyboardID != "" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let outputVC = storyboard.instantiateViewControllerWithIdentifier(storyboardID)
            self.rootViewController = outputVC
            self.makeKeyAndVisible()
        }
    }
}
