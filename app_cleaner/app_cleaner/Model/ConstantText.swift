//
//  ConstantText.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/14/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class ModelText {
    public static let share = ModelText()
    let textTitleHome = "Cleaner"
    let imgSetting = "settings"
    let txtPercent = "100"
    let percent = "%"
    let txtStorage = "Storage Available"
    let txtGB = "17.5 GB of 32GB"
    
    func arrayTxtHeader(header1: String, header2: String) -> [String]{
        return [header1, header2]
    }
    
    func arrayTxtCell() -> [[String]]{
       return [["Phot0", "Selfie", "Favorites", "Screenshots"],["Gif", "Live Photos"]]
    }
}
