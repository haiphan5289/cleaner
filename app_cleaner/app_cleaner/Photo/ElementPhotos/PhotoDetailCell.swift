//
//  PhotoDetailCell.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/19/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

protocol checkButtonDelegate {
    func CheckButton(count: Int)
}

class PhotoDetailCell: BaseCell {
    var imgPhotoDetailCell: UIImageView!
    var bt: UIButton!
    var checkDelegate: checkButtonDelegate?
    override func setupInitial() {
        super.setupInitial()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        setupViews()
    }
    
    func setupViews(){
        setupIMG()
        setupButtonSelect()
    }
    
    func setupButtonSelect(){
        bt = UIButton(type: .system)
        bt.layer.cornerRadius = 10
        bt.clipsToBounds = true
        bt.layer.borderColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView).cgColor
        bt.layer.borderWidth = 2
        bt.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        self.addSubview(bt)
        
        bt.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(20)
        }
    }
    
    @objc func handleSelect(sender: AnyObject){
        var numberCount = 0
        if let button = sender as? UIButton {
            if button.isSelected {
                numberCount -= 1
                button.isSelected = false
                button.setImage(UIImage(named: "uncheck"), for: .normal)
                checkDelegate?.CheckButton(count: numberCount)
            }
            else {
                numberCount += 1
                button.isSelected = true
                button.setImage(UIImage(named: "check"), for: .normal)
                checkDelegate?.CheckButton(count: numberCount)
            }
        }
    }
    
    func setupIMG(){
        imgPhotoDetailCell = UIImageView()
        imgPhotoDetailCell.clipsToBounds = true
        imgPhotoDetailCell.contentMode = .scaleToFill
        self.addSubview(imgPhotoDetailCell)
        
        imgPhotoDetailCell.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}
