//
//  HomeCell.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/16/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    var img: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
    }
    
    func setupViewCell(){
        setupIMG()
    }
    
    func setupIMG(){
        img = UIImageView()
        img.image = UIImage(named: "photo")
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        self.addSubview(img)
        
        img.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
