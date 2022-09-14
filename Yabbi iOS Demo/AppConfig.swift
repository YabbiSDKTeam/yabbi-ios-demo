//
//  AppConfig.swift
//  Yabbi iOS Demo
//
//  Created by perpointt on 14.09.2022.
//

import Foundation


class AppConfig {
    
    static var plist:NSDictionary {
        get {
            guard let filePath = Bundle.main.path(forResource: "Env", ofType: "plist") else {
                fatalError("Couldn't find file 'Env.plist'.")
            }
            
            guard let plist = NSDictionary(contentsOfFile: filePath) else {
                fatalError("Couldn't load plist")
            }
            
            return plist;
        }
    }
    
    static var YABBI_PUBLISHER_ID:String {
        get {
            plist.object(forKey: "YABBI_PUBLISHER_ID") as? String ?? ""
        }
    }
    
    static var YABBI_INTERSTITIAL_ID:String {
        get {
            plist.object(forKey: "YABBI_INTERSTITIAL_ID") as? String ?? ""
        }
    }
    
    static var YABBI_REWARDED_ID:String {
        get {
            plist.object(forKey: "YABBI_REWARDED_ID") as? String ?? ""
        }
    }
    
    static var YANDEX_INTERSTITIAL_ID:String {
        get {
            plist.object(forKey: "YANDEX_INTERSTITIAL_ID") as? String ?? ""
        }
    }
    
    static var YANDEX_REWARDED_ID:String {
        get {
            plist.object(forKey: "YANDEX_REWARDED_ID") as? String ?? ""
        }
    }
}
