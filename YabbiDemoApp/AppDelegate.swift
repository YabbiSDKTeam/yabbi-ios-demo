//
//  AppDelegate.swift
//  YabbiDemoApp
//
//  Created by perpointt on 23.11.2023.
//

import UIKit
import YabbiSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Yabbi.setCustomParams("appStoreAppID", EnvironmentVariables.appStoreAppID)
        Yabbi.enableDebug(true)
        Yabbi.initialize(publisherID: EnvironmentVariables.publisherID) { error in
            
        }
        
        return true
    }
}

