//
//  ViewController.swift
//  YabbiDemoApp
//
//  Created by perpointt on 29.08.2023.
//

import Foundation
import UIKit
import YabbiSDK

class ViewController:UITableViewController {
    @IBOutlet weak var sdkInfoLabel: UILabel!
    
    override func viewDidLoad() {
        let sdkVersion = Yabbi.sdkVersion
        
        sdkInfoLabel.text = "v\(sdkVersion)"
    }
}
