//
//  Extension.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/16/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit



extension UIViewController {
    func setupNavigation(text: String, isPhotoDetail: Bool){
        self.navigationController?.navigationBar.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroudnNavigation)
        self.navigationItem.title = text
        //setup màu của text navigation item
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //tạo 1 view cho Status Bar
        let viewStatusBar = UIView()
        viewStatusBar.backgroundColor = UIColor(red: 0/255, green: 125/255, blue: 254/255, alpha: 1)
        viewStatusBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 20)
        self.view.addSubview(viewStatusBar)
        
        //Kiểm tra, nếu là photodetai thì hiển thị Right Button
        if isPhotoDetail {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: nil)
        }
    }
    func setupCollectionExtension(isHeader: Bool, spacingItem: CGFloat) -> UICollectionView{
//        guard let size = self.navigationController?.navigationBar.frame else { return }
        let layout = UICollectionViewFlowLayout()
        //setup size cho header
        if isHeader {
            layout.headerReferenceSize = CGSize(width: 10, height: 50)
        }
        //setup khoảng cách giưã các cell
        //khoảng cách trái phải giữa các cell
        layout.minimumInteritemSpacing = spacingItem
        //khoảng cách trên dưới giưa các cell
        layout.minimumLineSpacing = 20
        //        layout.footerReferenceSize = CGSize(width: 50, height: 50)
        let collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        if let size = self.navigationController?.navigationBar.frame {
            self.view.addSubview(collect)
            collect.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
            collect.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalToSuperview().offset(size.height + 20)
            }
//            collect.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            return collect
        }
        return collect
    }
    
}
extension UICollectionReusableView {
    func setupHeader(isVideo: Bool) -> UILabel{
        let txtHeader = UILabel()
        txtHeader.font = UIFont.boldSystemFont(ofSize: 30)
        txtHeader.textAlignment = .left
        txtHeader.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
        self.addSubview(txtHeader)
        txtHeader.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        if isVideo {
            txtHeader.textColor = UIColor(red: 0/255, green: 114/255, blue: 252/255, alpha: 1)
        }
        return txtHeader
    }
}


