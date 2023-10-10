//
//  RewardedViewController.swift
//  YabbiAds_Example
//
//  Created by perpointt on 29.08.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import YabbiAds

class RewardedViewController:UIViewController {
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var mediationPopupButton: UIButton!
    
    var placementName:String = EnvironmentVariables.yabbiRewardedUnitID
    
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
        
        YabbiAds.setRewardedDelegate(self)
        
        addLog("YabbiAds \(YabbiAds.sdkVersion) initialized.")
    }
    
    @IBAction func loadAd(_ sender: Any) {
        if (YabbiAds.canLoadAd(YabbiAds.REWARDED, placementName)) {
            addLog("Ad start to load.")
            YabbiAds.loadAd(YabbiAds.REWARDED, placementName)
        } else {
            addLog("SDK can't start load ad.")
        }
    }
    
    @IBAction func showAd(_ sender: Any) {
        if (YabbiAds.isAdLoaded(YabbiAds.REWARDED, placementName)) {
            YabbiAds.showAd(
                adType: YabbiAds.REWARDED,
                placementName: placementName,
                rootViewController: self
            )
        } else {
            addLog("Ad is not loaded yet")
        }
       
    }
    
    @IBAction func destroyAd(_ sender: Any) {
        YabbiAds.destroyAd(YabbiAds.REWARDED, placementName)
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
            placementName = EnvironmentVariables.yabbiRewardedUnitID
            break
        case MediationNetworks.yandex:
            placementName = EnvironmentVariables.yandexRewardedlUnitID
            break
        case MediationNetworks.ironsource:
            placementName = EnvironmentVariables.ironsourceRewardedlUnitID
            break
        case MediationNetworks.mintegral:
            placementName = EnvironmentVariables.mintegraleRewardedlUnitID
            break
        default:
            break
        }
    }
}




extension RewardedViewController:YbiRewardedDelegate {
    func onRewardedLoaded() {
        addLog("onRewardedLoaded: Ad loaded and ready to show.")
    }
    
    func onRewardedLoadFailed(_ error: AdException) {
        addLog("onRewardedLoadFailed: Ad was not loaded. \(error.localizedDescription) (\(error.caused)).")
    }
    
    func onRewardedShown() {
        addLog("onRewardedShown: Ad shown.")
    }
    
    func onRewardedShowFailed(_ error: AdException) {
        addLog("onRewardedShowFailed: Ad was not shown. \(error.localizedDescription) (\(error.caused)).")
    }
    
    func onRewardedClosed() {
        addLog("onRewardedClosed: Ad closed.")
    }
    
    func onRewardedFinished() {
        addLog("onRewardedFinished: Ad was finished.")
    }
}