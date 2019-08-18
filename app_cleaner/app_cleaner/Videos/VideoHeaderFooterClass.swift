//
//  VideoHeaderFooterClass.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class VideoHeaderFooterClass: BaseHeader {
    var lb: UILabel!
    override func setupInitial() {
        super.setupInitial()
        setupViews()
    }
    func setupViews(){
        lb = self.setupHeader(isVideo: true)
        
    }
}
