//
//  FunctionAll.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

enum BackGroundColorObject {
    case backgroundView, backgroundCell, backgroudnNavigation, colorDefault
}

class FunctionAll {
    public static let share = FunctionAll()
    func BackGroundColor(typeColor: BackGroundColorObject) -> UIColor{
        let br: BackGroundColorObject = typeColor
        switch br {
        case .backgroudnNavigation:
            return UIColor(red: 0/255, green: 125/255, blue: 254/255, alpha: 1)
        case .backgroundCell:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        case .backgroundView:
            return UIColor(red: 239/255, green: 238/255, blue: 243/255, alpha: 1)
        //            return UIColor.darkGray
//        case .colorDefault:
//            return UIColor(red: 61/255, green: 91/255, blue: 161/255, alpha: 1)
        default:
            return UIColor(red: 61/255, green: 91/255, blue: 161/255, alpha: 1)
        }
    }

}
