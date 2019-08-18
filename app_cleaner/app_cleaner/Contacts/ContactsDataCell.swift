//
//  ContactsData.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class ContactsDataCell: BaseCell {
    override func setupInitial() {
        super.setupInitial()
        self.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundCell)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
