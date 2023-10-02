//
//  AppDelegate.swift
//  YabbiAds
//
//  Created by 58557830 on 11/03/2022.
//  Copyright (c) 2022 58557830. All rights reserved.
//

import UIKit
import YabbiAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        YabbiAds.setCustomParams(ExternalInfoStrings.appStoreAppID, EnvironmentVariables.appStoreAppID)
        YabbiAds.enableDebug(true)
        YabbiAds.initialize(publisherID: EnvironmentVariables.publisherID)
        
        return true
    }
}

