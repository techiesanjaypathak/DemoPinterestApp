//
//  AppConstants.swift
//  PinterestLikeApp
//
//  Created by SanjayPathak on 17/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {

    struct ListConstants {
        static let themeColor = UIColor(red: (61.0 / 255.0), green: (164.0 / 255.0), blue: (194.0 / 255.0), alpha: 1.0)
        static let footerViewReuseIdentifier = "RefreshFooterView"
    }

    struct Paths {
        static let DocumentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        static let CoreDataPath = ""
    }
}
