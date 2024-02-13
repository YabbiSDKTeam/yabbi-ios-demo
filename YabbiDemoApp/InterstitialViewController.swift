//
//  InterstitialViewController.swift
//  YabbiDemoApp
//
//  Created by perpointt on 29.08.2023.
//

import Foundation
import UIKit
import YabbiSDK

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
        
        Yabbi.setInterstitialDelegate(self)
        
        addLog("Yabbi \(Yabbi.sdkVersion) initialized.")
    }
    
    @IBAction func loadAd(_ sender: Any) {
        if (Yabbi.canLoadAd(Yabbi.INTERSTITIAL, placementName)) {
            addLog("Ad start to load.")
            Yabbi.loadAd(Yabbi.INTERSTITIAL, placementName)
        } else {
            addLog("SDK can't start load ad.")
        }
    }
    
    @IBAction func showAd(_ sender: Any) {
        if (Yabbi.isAdLoaded(Yabbi.INTERSTITIAL, placementName)) {
            Yabbi.showAd(
                adType: Yabbi.INTERSTITIAL,
                placementName: placementName,
                rootViewController: self
            )
        } else {
            addLog("Ad is not loaded yet")
        }
        
    }
    
    @IBAction func destroyAd(_ sender: Any) {
        Yabbi.destroyAd(Yabbi.INTERSTITIAL, placementName)
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
        case MediationNetworks.applovin:
            placementName = EnvironmentVariables.applovinInterstitialUnitID
            break
        default:
            break
        }
    }
}



extension InterstitialViewController:InterstitialDelegate {
    func onInterstitialLoaded(_ adPayload:AdPayload) {
        addLog("onInterstitialLoaded: Ad loaded and ready to show.")
    }
    
    func onInterstitialLoadFailed(_ adPayload:AdPayload, _ error: AdException) {
        addLog("onInterstitialLoadFailed: Ad was not loaded. \(error.localizedDescription) (\(error.caused)).")
    }
    
    func onInterstitialShown(_ adPayload:AdPayload) {
        addLog("onInterstitialShown: Ad shown.")
    }
    
    func onInterstitialShowFailed(_ adPayload:AdPayload, _ error: AdException) {
        addLog("onInterstitialLoadFailed: Ad was not shown. \(error.localizedDescription) (\(error.caused)).")
    }
    
    func onInterstitialClosed(_ adPayload:AdPayload) {
        addLog("onInterstitialClosed: Ad closed.")
    }
}
