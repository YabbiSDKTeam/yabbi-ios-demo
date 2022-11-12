//
//  AppDelegate.swift
//  Yabbi iOS Demo
//
//  Created by perpointt on 22.06.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           YbiConsentManager.setDelegate(self)
           YbiConsentManager.enableLog(true)
           YbiConsentManager.registerCustomVendor { builder in
               let _ = builder.appendPolicyURL("https://yabbi.me/privacy-policies")
           }
           YbiConsentManager.loadManager()
           return true
       }
}

