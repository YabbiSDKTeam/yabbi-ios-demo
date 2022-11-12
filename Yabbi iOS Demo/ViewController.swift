//
//  ViewController.swift
//  Yabbi iOS Demo
//
//  Created by perpointt on 22.06.2022.
//

import UIKit
import YabbiAds
import CoreLocation
import YBIConsentManager


class ViewController: UIViewController, YbiInterstitialDelegate, YbiRewardedDelegate, YbiConsentDelegate  {
    
    @IBOutlet weak var pubIDField: UITextField!
    @IBOutlet weak var interstitialUnitIDField: UITextField!
    @IBOutlet weak var rewardedUnitIDField: UITextField!
    @IBOutlet weak var LogField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        
        pubIDField.text = AppConfig.YABBI_PUBLISHER_ID
        interstitialUnitIDField.text = AppConfig.YABBI_INTERSTITIAL_ID
        rewardedUnitIDField.text = AppConfig.YABBI_REWARDED_ID
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        YbiConsentManager.setDelegate(self)
        YbiConsentManager.enableLog(true)
        YbiConsentManager.registerCustomVendor { builder in
            let _ = builder
                .appendPolicyURL("https://yabbi.me/privacy-policies")
                .appendGDPR(true)
                .appendBundle("me.yabbi.ads")
                .appendName("Test name")
        }
        YbiConsentManager.loadManager()
    }
    
    @IBAction func initializeSDK(_ sender: Any) {
        if(YbiConsentManager.hasConsent) {
            initYabbi()
        } else {
            YbiConsentManager.showConsentWindow(self)
        }
    }
    
    private func initYabbi(){
        let pubID = pubIDField.text ?? ""
        let bannerID = interstitialUnitIDField.text ?? ""
        let rewardedID = rewardedUnitIDField.text ?? ""
        
        let configuration = YabbiConfiguration(
            publisherID: pubID,
            interstitialID: bannerID,
            rewardedID: rewardedID
        )
        
        YabbiAds.setCustomParams(YBIAdaptersParameters.yandexInterstitialID, AppConfig.YANDEX_INTERSTITIAL_ID)
        YabbiAds.setCustomParams(YBIAdaptersParameters.yandexInterstitialID, AppConfig.YANDEX_REWARDED_ID)
        
        
        
        YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralAppID, AppConfig.MINTEGRAL_APP_ID)
        
        YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralApiKey, AppConfig.MINTEGRAL_API_KEY)
        
        YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralInterstitialPlacementId, AppConfig.MINTEGRAL_INTERSTITIAL_PLACEMENT_ID)
        
        YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralInterstitialUnitId, AppConfig.MINTEGRAL_INTERSTITIAL_UNIT_ID)
        
        YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralRewardedPlacementId, AppConfig.MINTEGRAL_REWARDED_PLACEMENT_ID)
        
        YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralRewardedUnitId, AppConfig.MINTEGRAL_REWARDED_UNIT_ID)
        
        YabbiAds.initialize(configuration)
        YabbiAds.setInterstitialDelegate(self)
        YabbiAds.setRewardedDelegate(self)
       
        
        writeNewLog(messgae: "PubID: \(pubID)\nBannerID: \(bannerID)\nVideoID: \(rewardedID)", new: true)
    }
   
    func onConsentManagerLoaded() {
        writeNewLog(messgae: "onConsentManagerLoaded", new: true)
    }
    
    func onConsentManagerLoadFailed(_ error: String) {
        writeNewLog(messgae: "onConsentManagerLoadFailed \(error)", new: false)
    }
    
    func onConsentWindowShown() {
        writeNewLog(messgae: "onConsentWindowShown", new: false)
    }
    
    func onConsentManagerShownFailed(_ error: String) {
        writeNewLog(messgae: "onConsentManagerShownFailed \(error)", new: false)
    }
    
    func onConsentWindowClosed(_ hasConsent: Bool) {
        writeNewLog(messgae: "onConsentManagerShownFailed - hasConsent: \(hasConsent)", new: false)
        initYabbi()
    }
    
    @IBAction func IntersititialButtonTapped(_ sender: Any) {
        writeNewLog(messgae: "Interstitial ad loading", new: true)
        YabbiAds.loadAd(AdType.INTERSTITIAL)
    }
    
    @IBAction func VideoButtonTapped(_ sender: Any) {
        writeNewLog(messgae: "Rewarded ad loading", new: true)
        YabbiAds.loadAd(AdType.REWARDED)
    }
    
    private func writeNewLog(messgae:String, new: Bool = false) -> Void{
        
        if(new){
            LogField.text = "\(messgae)"
        }else {
            let current = LogField.text ?? ""
            LogField.text = "\(current)\n\(messgae)"
        }
        
    }
    
    private func configureTextFields(){
        [pubIDField,interstitialUnitIDField, rewardedUnitIDField].forEach { textField in
            guard let field = textField else {
                return
            }
            
            field.layer.borderWidth = 1
            field.layer.cornerRadius = 4
            field.layer.masksToBounds = true
            field.layer.borderColor =  UIColor(red: 0.63, green: 0.67, blue: 0.70, alpha: 1.00).cgColor
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func onInterstitialLoaded() {
        writeNewLog(messgae: "onInterstitialLoaded", new: false)
        YabbiAds.showAd(AdType.INTERSTITIAL, self)
    }
    
    func onInterstitialLoadFailed(_ error: String) {
        writeNewLog(messgae: "onInterstitialLoadFailed: \(error)", new: false)
    }
    
    func onInterstitialShown() {
        writeNewLog(messgae: "onInterstitialShown", new: false)
    }
    
    func onInterstitialShowFailed(_ error: String) {
        writeNewLog(messgae: "onInterstitialShowFailed: \(error)", new: false)
    }
    
    func onInterstitialClosed() {
        writeNewLog(messgae: "onInterstitialClosed", new: false)
    }
    
    func onRewardedLoaded() {
        YabbiAds.showAd(AdType.REWARDED, self)
        writeNewLog(messgae: "onRewardedVideolLoaded", new: false)
    }
    
    func oRewardedLoadFailed(_ error: String) {
        writeNewLog(messgae: "oRewardedVideoLoadFailed: \(error)", new: false)
    }
    
    func onRewardedShown() {
        writeNewLog(messgae: "onRewardedVideoShown", new: false)
    }
    
    func onRewardedShowFailed(_ error: String) {
        writeNewLog(messgae: "onRewardedVideoShowFailed: \(error)", new: false)
    }
    
    func onRewardedClosed() {
        writeNewLog(messgae: "onRewardedVideoClosed", new: false)
    }
    
    func onRewardedFinished() {
        writeNewLog(messgae: "onRewardedVideoFinished", new: false)
    }
    
}


typealias LogAlias = (String, Bool)  -> Void


