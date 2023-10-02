//
//  ViewController.swift
//  YabbiAds_Example
//
//  Created by perpointt on 29.08.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import YabbiAds

class ViewController:UITableViewController {
    @IBOutlet weak var sdkInfoLabel: UILabel!
    
    override func viewDidLoad() {
        let sdkVersion = YabbiAds.sdkVersion
        
        sdkInfoLabel.text = "v\(sdkVersion)"
    }
}
