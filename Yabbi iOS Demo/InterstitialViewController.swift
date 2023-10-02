//
//  InterstitialViewController.swift
//  YabbiAds_Example
//
//  Created by perpointt on 29.08.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import YabbiAds

class InterstitialViewController:UIViewController {
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var mediationPopupButton: UIButton!
    
    var placementName:String = EnvironmentVariables.yabbiInterstitialUnitID
    
    override func viewDidLoad() {
        if #available(iOS 14.0, *) {
            let optionClosure = { [self](action:UIAction) in
                mediationPopupButton.setTitle(action.title, for: .normal)
                selectPlacementName(action.title)
                addLog("Ad will be loaded from \(action.title).")
            }
            
            mediationPopupButton.setTitle(MediationNetworks.yabbi, for: .normal)
            setMediationPopup(mediationPopupButton, optionClosure)
        } else {
            mediationPopupButton.isEnabled = false
            mediationPopupButton.setTitle("Avaliable from iOS 14.0", for: .normal)
            
            addLog("Mediation avaliable only from iOS 14.0.")
        }
        
        YabbiAds.setInterstitialDelegate(self)
        
        addLog("YabbiAds \(YabbiAds.sdkVersion) initialized.")
    }
    
    @IBAction func loadAd(_ sender: Any) {
        if (YabbiAds.canLoadAd(YabbiAds.INTERSTITIAL, placementName)) {
            addLog("Ad start to load.")
            YabbiAds.loadAd(YabbiAds.INTERSTITIAL, placementName)
        } else {
            addLog("SDK can't start load ad.")
        }
    }
    
    @IBAction func showAd(_ sender: Any) {
        if (YabbiAds.isAdLoaded(YabbiAds.INTERSTITIAL, placementName)) {
            YabbiAds.showAd(
                adType: YabbiAds.INTERSTITIAL,
                placementName: placementName,
                rootViewController: self
            )
        } else {
            addLog("Ad is not loaded yet")
        }
        
    }
    
    @IBAction func destroyAd(_ sender: Any) {
        YabbiAds.destroyAd(YabbiAds.INTERSTITIAL, placementName)
        addLog("Ad was destroyed.")
    }
    @IBAction func clearLog(_ sender: Any) {
        eventsLabel.text = "* YabbiAds \(YabbiAds.sdkVersion) initialized."
    }
    
    func addLog(_ message:String) {
        let text = eventsLabel.text ?? ""
        eventsLabel.text = "\(text)\(text.isEmpty ? "" : "\n")* \(message)"
    }
    
    func selectPlacementName(_ network:String) {
        switch(network) {
        case MediationNetworks.yabbi:
            placementName = EnvironmentVariables.yabbiInterstitialUnitID
            break
        case MediationNetworks.yandex:
            placementName = EnvironmentVariables.yandexInterstitialUnitID
            break
        case MediationNetworks.ironsource:
            placementName = EnvironmentVariables.ironsourceInterstitialUnitID
            break
        case MediationNetworks.mintegral:
            placementName = EnvironmentVariables.mintegralInterstitialUnitID
            break
        default:
            break
        }
    }
}



extension InterstitialViewController:YbiInterstitialDelegate {
    func onInterstitialLoaded() {
        addLog("onInterstitialLoaded: Ad loaded and ready to show.")
    }
    
    func onInterstitialLoadFailed(_ error: AdException) {
        addLog("onInterstitialLoadFailed: Ad was not loaded. \(error.localizedDescription) (\(error.caused)).")
    }
    
    func onInterstitialShown() {
        addLog("onInterstitialShown: Ad shown.")
    }
    
    func onInterstitialShowFailed(_ error: AdException) {
        addLog("onInterstitialLoadFailed: Ad was not shown. \(error.localizedDescription) (\(error.caused)).")
    }
    
    func onInterstitialClosed() {
        addLog("onInterstitialClosed: Ad closed.")
    }
}
