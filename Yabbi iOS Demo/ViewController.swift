import UIKit
import YabbiAds
import CoreLocation
import YBIConsentManager


class ViewController: UIViewController  {
    
    @IBOutlet weak var Logger: UILabel!
    
    @IBAction func loadInterstitialAd(_ sender: Any) {
        YabbiAds.loadAd(YabbiAds.INTERSTITIAL)
    }
    @IBAction func showInterstitialAd(_ sender: Any) {
        YabbiAds.showAd(YabbiAds.INTERSTITIAL, self)
    }
    @IBAction func destroyInterstitialAd(_ sender: Any) {
        YabbiAds.destroyAd(YabbiAds.INTERSTITIAL)
    }
    
    @IBAction func loadRewardedAd(_ sender: Any) {
        YabbiAds.loadAd(YabbiAds.REWARDED)
    }
    @IBAction func showRewardedAd(_ sender: Any) {
        YabbiAds.showAd(YabbiAds.REWARDED, self)
    }
    @IBAction func destroyRewardedAd(_ sender: Any) {
        YabbiAds.destroyAd(YabbiAds.REWARDED)
    }
    
    @IBAction func showConsent(_ sender: Any) {
        YbiConsentManager.showConsentWindow(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeYabbi()
    }
    
    private func initializeYabbi() {
        YbiConsentManager.setDelegate(self)
        YabbiAds.setInterstitialDelegate(self)
        YabbiAds.setRewardedDelegate(self)
        
        guard let filePath = Bundle.main.path(forResource: "Env", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath) else {
            logEvent("Env.plist not found. See instruction https://mobileadx.gitbook.io/mobileadx/mobileadx/dokumentaciya-na-russkom/ios-sdk/ustanovka-demo-prilozheniya");
            return
        }
        
        let APPSTORE_ID = getKeyFromPlist(plist, "APPSTORE_ID")
        
        let YABBI_PUBLISHER_ID = getKeyFromPlist(plist, "YABBI_PUBLISHER_ID")
        let YABBI_INTERSTITIAL_ID = getKeyFromPlist(plist, "YABBI_INTERSTITIAL_ID")
        let YABBI_REWARDED_ID = getKeyFromPlist(plist, "YABBI_REWARDED_ID")
        

        let MINTEGRAL_APP_ID = getKeyFromPlist(plist, "MINTEGRAL_APP_ID")
        let MINTEGRAL_API_KEY = getKeyFromPlist(plist, "MINTEGRAL_API_KEY")
        let MINTEGRAL_INTERSTITIAL_PLACEMENT_ID = getKeyFromPlist(plist, "MINTEGRAL_INTERSTITIAL_PLACEMENT_ID")
        let MINTEGRAL_INTERSTITIAL_ID = getKeyFromPlist(plist, "MINTEGRAL_INTERSTITIAL_ID")
        let MINTEGRAL_REWARDED_PLACEMENT_ID = getKeyFromPlist(plist, "MINTEGRAL_REWARDED_PLACEMENT_ID")
        let MINTEGRAL_REWARDED_ID = getKeyFromPlist(plist, "MINTEGRAL_REWARDED_ID")
        
        
        YabbiAds.setCustomParams(ExternalInfoStrings.appStoreAppID, APPSTORE_ID)

        
        YabbiAds.setCustomParams(ExternalInfoStrings.mintegralAppID, MINTEGRAL_APP_ID)
        YabbiAds.setCustomParams(ExternalInfoStrings.mintegralApiKey, MINTEGRAL_API_KEY)
        YabbiAds.setCustomParams(ExternalInfoStrings.mintegralInterstitialPlacementId, MINTEGRAL_INTERSTITIAL_PLACEMENT_ID)
        YabbiAds.setCustomParams(ExternalInfoStrings.mintegralInterstitialUnitId, MINTEGRAL_INTERSTITIAL_ID)
        YabbiAds.setCustomParams(ExternalInfoStrings.mintegralRewardedPlacementId, MINTEGRAL_REWARDED_PLACEMENT_ID)
        YabbiAds.setCustomParams(ExternalInfoStrings.mintegralRewardedUnitId, MINTEGRAL_REWARDED_ID)
        
        let config = YabbiConfiguration(
            publisherID: YABBI_PUBLISHER_ID,
            interstitialID: YABBI_INTERSTITIAL_ID,
            rewardedID: YABBI_REWARDED_ID
        )
        
        YabbiAds.setUserConsent(YbiConsentManager.hasConsent)
        YabbiAds.enableDebug(true)
        
        YabbiAds.initialize(config)
        
        YbiConsentManager.loadManager()
    }
    
    private func getKeyFromPlist(_  plist:NSDictionary, _ key:String) -> String {
        return plist.object(forKey: key) as? String ?? ""
    }
    
    func logEvent(_ messgae:String) -> Void{
        let current = Logger.text ?? ""
        Logger.text = "\(current)\n\(messgae)"
    }
}

extension ViewController:YbiConsentDelegate{
    func onConsentManagerLoaded() {
        logEvent( "onConsentManagerLoaded")
    }
    
    func onConsentManagerLoadFailed(_ error: String) {
        logEvent("onConsentManagerLoadFailed \(error)")
    }
    
    func onConsentWindowShown() {
        logEvent("onConsentWindowShown")
    }
    
    func onConsentManagerShownFailed(_ error: String) {
        logEvent("onConsentManagerShownFailed \(error)")
    }
    
    func onConsentWindowClosed(_ hasConsent: Bool) {
        YabbiAds.setUserConsent(hasConsent)
        logEvent("onConsentWindowClosed - hasConsent: \(hasConsent)")
    }
}


extension ViewController:YbiRewardedDelegate {
    func onRewardedLoaded() {
        logEvent("onRewardedVideolLoaded")
    }
    
    func onRewardedLoadFailed(_ error: String) {
        logEvent("oRewardedVideoLoadFailed: \(error)")
    }
    
    func onRewardedShown() {
        logEvent("onRewardedVideoShown")
    }
    
    func onRewardedShowFailed(_ error: String) {
        logEvent("onRewardedVideoShowFailed: \(error)")
    }
    
    func onRewardedClosed() {
        logEvent("onRewardedVideoClosed")
    }
    
    func onRewardedFinished() {
        logEvent("onRewardedVideoFinished")
    }
}


extension ViewController: YbiInterstitialDelegate{
    func onInterstitialLoaded() {
        logEvent("onInterstitialLoaded")
    }
    
    func onInterstitialLoadFailed(_ error: String) {
        logEvent("onInterstitialLoadFailed: \(error)")
    }
    
    func onInterstitialShown() {
        logEvent("onInterstitialShown")
    }
    
    func onInterstitialShowFailed(_ error: String) {
        logEvent("onInterstitialShowFailed: \(error)")
    }
    
    func onInterstitialClosed() {
        logEvent("onInterstitialClosed")
    }
}
