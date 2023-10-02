//
//  ConsentManagerViewController.swift
//  YabbiAds_Example
//
//  Created by perpointt on 29.08.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import YabbiAds
import YBIConsentManager

class ConsentManagerViewController:UIViewController {
    @IBOutlet weak var eventsLabel: UILabel!
    
    var storage:UserDefaults?
    
    override func viewDidLoad() {
        storage = UserDefaults(suiteName: "Demo app")
        YbiConsentManager.enableLog(true)
        YbiConsentManager.setDelegate(self)
        
        if let storage = self.storage {
            YbiConsentManager.setCustomStorage(storage)
        }
        
        addLog("Consent window initialized.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        YbiConsentManager.registerCustomVendor { builder in
            let _ = builder
                .appendPolicyURL("https://yabbi.me/privacy-policies")
                .appendBundle("me.yabbi.ads.app")
                .appendName("Test name")
        }
    }
    
    @IBAction func showGDPRwindow(_ sender: Any) {
        clearStorage()
        
        YbiConsentManager.registerCustomVendor { builder in
            let _ = builder.appendGDPR(true)
        }
        
        YbiConsentManager.loadManager()
    }
    @IBAction func showNoGDPRwindow(_ sender: Any) {
        clearStorage()
        
        YbiConsentManager.registerCustomVendor { builder in
            let _ = builder.appendGDPR(false)
        }
        
        YbiConsentManager.loadManager()
    }
    
    @IBAction func clearLog(_ sender: Any) {
        eventsLabel.text = "* Consent window initialized."
    }
    
    func addLog(_ message:String) {
        let text = eventsLabel.text ?? ""
        eventsLabel.text = "\(text)\(text.isEmpty ? "" : "\n")* \(message)"
    }
    
    func clearStorage() {
        storage?.removeObject(forKey: "consentAlreadyAsked")
        storage?.removeObject(forKey: "hasConsent")
    }
}

extension ConsentManagerViewController:YbiConsentDelegate {
    func onConsentManagerLoaded() {
        addLog("onConsentManagerLoaded: Consent window ready to show.")
        YbiConsentManager.showConsentWindow(self)
    }
    
    func onConsentManagerLoadFailed(_ error: String) {
        addLog("onConsentManagerLoadFailed: Consent window did not load. \(error).")
    }
    
    func onConsentWindowShown() {
        addLog("onConsentWindowShown: Consent window shown.")
    }
    
    func onConsentManagerShownFailed(_ error: String) {
        addLog("onConsentManagerShownFailed: Consent window did not show. \(error).")
    }
    
    func onConsentWindowClosed(_ hasConsent: Bool) {
        addLog("onConsentWindowClosed: User consent \(hasConsent ? "" : "not") received.")
        YabbiAds.setUserConsent(hasConsent)
    }
}
