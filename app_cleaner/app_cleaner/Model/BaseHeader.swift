//
//  BaseHeader.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

//tạo 1 cell base để các cell khác kế thùa đỡ vất vả
class BaseHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitial()
    }
    
    func setupInitial(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
