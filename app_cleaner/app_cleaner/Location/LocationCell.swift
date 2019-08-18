//
//  LocationCell.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class LocationCell: BaseCell {
    var lbSubTitle: UILabel!
    var img: UIImageView!
    override func setupInitial() {
        super.setupInitial()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        setupViews()
    }
    
    func setupViews(){
        setupSubTitle()
        setupMap()
    }
    
    func setupSubTitle(){
        lbSubTitle = UILabel()
        lbSubTitle.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroudnNavigation)
        self.addSubview(lbSubTitle)
        
        lbSubTitle.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func setupMap(){
        img = UIImageView()
        img.backgroundColor = .orange
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.lbSubTitle.snp.top)
        }
    }
}
