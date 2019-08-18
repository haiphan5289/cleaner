//
//  ContactsHeader.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class ContactsHeader: BaseHeader {
    var txtContactHeader: UILabel!
    override func setupInitial() {
        super.setupInitial()
        self.backgroundColor = .brown
        setupViews()
    }
    func setupViews(){
         txtContactHeader = self.setupHeader(isVideo: false)
    }

}
