//
//  PhotoCell.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    var imgCell: UIImageView!
    var txtCell: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        setupViews()
    }
    
    func setupViews(){
        setupTxtCell()
        setupIMG()
    }
    
    func setupTxtCell(){
        txtCell = UILabel()
        txtCell.backgroundColor = UIColor.green
        txtCell.textAlignment = .center
        self.addSubview(txtCell)
        
        txtCell.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func setupIMG(){
        imgCell = UIImageView()
        imgCell.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .colorDefault)
        self.addSubview(imgCell)
        
        imgCell.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.txtCell.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
