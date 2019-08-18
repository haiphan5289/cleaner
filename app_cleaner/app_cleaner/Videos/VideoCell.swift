//
//  VideoCell.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    override func setupInitial() {
        super.setupInitial()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

}
