//
//  RewardedViewController.swift
//  YabbiDemoApp
//
//  Created by perpointt on 29.08.2023.
//

import Foundation
import UIKit
import YabbiSDK

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
        
        Yabbi.setRewardedDelegate(self)
        
        addLog("Yabbi \(Yabbi.sdkVersion) initialized.")
    }
    
    @IBAction func loadAd(_ sender: Any) {
        if (Yabbi.canLoadAd(Yabbi.REWARDED, placementName)) {
            addLog("Ad start to load.")
            Yabbi.loadAd(Yabbi.REWARDED, placementName)
        } else {
            addLog("SDK can't start load ad.")
        }
    }
    
    @IBAction func showAd(_ sender: Any) {
        if (Yabbi.isAdLoaded(Yabbi.REWARDED, placementName)) {
            Yabbi.showAd(
                adType: Yabbi.REWARDED,
                placementName: placementName,
                rootViewController: self
            )
        } else {
            addLog("Ad is not loaded yet")
        }
       
    }
    
    @IBAction func destroyAd(_ sender: Any) {
        Yabbi.destroyAd(Yabbi.REWARDED, placementName)
        addLog("Ad was destroyed.")
    }
    
    @IBAction func clearLog(_ sender: Any) {
        eventsLabel.text = "* Yabbi \(Yabbi.sdkVersion) initialized."
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
            placementName = EnvironmentVariables.mintegralRewardedlUnitID
            break
        case MediationNetworks.applovin:
            placementName = EnvironmentVariables.applovinRewardedlUnitID
            break
        default:
            break
        }
    }
}




extension RewardedViewController:RewardedDelegate {
    func onRewardedLoaded(_ adPayload:AdPayload) {
        addLog("onRewardedLoaded: Ad loaded and ready to show.")
    }
    
    func onRewardedLoadFailed(_ adPayload:AdPayload, _ error: AdException) {
        addLog("onRewardedLoadFailed: Ad was not loaded. \(error.localizedDescription) (\(error.caused)).")
    }
    
    func onRewardedShown(_ adPayload:AdPayload) {
        addLog("onRewardedShown: Ad shown.")
    }
    
    func onRewardedShowFailed(_ adPayload:AdPayload, _ error: AdException) {
        addLog("onRewardedShowFailed: Ad was not shown. \(error.localizedDescription) (\(error.caused)).")
    }
    
    func onRewardedClosed(_ adPayload:AdPayload) {
        addLog("onRewardedClosed: Ad closed.")
    }
    
    func onRewardedFinished(_ adPayload:AdPayload) {
        addLog("onRewardedFinished: Ad was finished.")
    }
}
