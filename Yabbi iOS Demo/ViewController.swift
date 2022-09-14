//
//  ViewController.swift
//  Yabbi iOS Demo
//
//  Created by perpointt on 22.06.2022.
//

import UIKit
import YabbiAds
import CoreLocation


class ViewController: UIViewController, YabbiInterstitialDelegate, YabbiRewardedVideoDelegate, CLLocationManagerDelegate  {
    
    @IBOutlet weak var pubIDField: UITextField!
    @IBOutlet weak var interstitialUnitIDField: UITextField!
    @IBOutlet weak var rewardedUnitIDField: UITextField!
    @IBOutlet weak var LogField: UITextView!
    
    let YABBI_PUBLISHER_ID = ProcessInfo.processInfo.environment["YABBI_PUBLISHER_ID"]
    let YABBI_INTERSTITIAL_ID = ProcessInfo.processInfo.environment["YABBI_INTERSTITIAL_ID"]
    let YABBI_REWARDED_ID = ProcessInfo.processInfo.environment["YABBI_REWARDED_ID"]
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        
        pubIDField.text = YABBI_PUBLISHER_ID
        interstitialUnitIDField.text = YABBI_INTERSTITIAL_ID
        rewardedUnitIDField.text = YABBI_REWARDED_ID
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        initializeSDK(self)
    }
    
    @IBAction func initializeSDK(_ sender: Any) {
        let pubID = pubIDField.text ?? ""
        let bannerID = interstitialUnitIDField.text ?? ""
        let rewardedID = rewardedUnitIDField.text ?? ""
        
        let configuration = YabbiConfiguration(
            publisherID: pubID,
            interstitialID: bannerID,
            rewardedID: rewardedID
        )
        
        YabbiAds.initialize(configuration)
        YabbiAds.setInterstitialDelegate(self)
        YabbiAds.setRewardedDelegate(self)
       
        locationManager?.requestWhenInUseAuthorization()
        writeNewLog(messgae: "PubID: \(pubID)\nBannerID: \(bannerID)\nVideoID: \(rewardedID)", new: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       // You can handle status here
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
        YabbiAds.showAd(AdType.INTERSTITIAL, rootViewController: self)
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
    
    func onRewardedVideolLoaded() {
        YabbiAds.showAd(AdType.REWARDED, rootViewController: self)
        writeNewLog(messgae: "onRewardedVideolLoaded", new: false)
    }
    
    func oRewardedVideoLoadFailed(_ error: String) {
        writeNewLog(messgae: "oRewardedVideoLoadFailed: \(error)", new: false)
    }
    
    func onRewardedVideoShown() {
        writeNewLog(messgae: "onRewardedVideoShown", new: false)
    }
    
    func onRewardedVideoShowFailed(_ error: String) {
        writeNewLog(messgae: "onRewardedVideoShowFailed: \(error)", new: false)
    }
    
    func onRewardedVideoClosed() {
        writeNewLog(messgae: "onRewardedVideoClosed", new: false)
    }
    
    func onRewardedVideoFinished() {
        writeNewLog(messgae: "onRewardedVideoFinished", new: false)
    }
    
}


typealias LogAlias = (String, Bool)  -> Void


