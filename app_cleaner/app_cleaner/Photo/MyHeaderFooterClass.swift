//
//  MyHeaderFooterClass.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/17/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class MyHeaderFooterClass: UICollectionReusableView {
    var txtHeader = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        setupTitleHeader()
    }
    
    func setupTitleHeader(){
//        txtHeader.text = "Duplicate"
        txtHeader.font = UIFont.boldSystemFont(ofSize: 30)
        txtHeader.textAlignment = .left
//        txtHeader.backgroundColor = .green
        self.addSubview(txtHeader)
        txtHeader.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
