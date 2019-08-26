//
//  Extension.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/16/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import Photos


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
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: nil)
        }

    }
    
    //setup & Config clean button
    func setupClearButton(title: String) -> UIButton{
        let bt = UIButton(type: .system)
        bt.setTitle(title, for: .normal)
        //        btClean.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        self.view.addSubview(bt)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bt)
        return bt
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
    
    //Setup & Config button Delete
    func setupDeleteButton(textTitle: String) -> UIButton{
        let btDelete: UIButton!
        btDelete = UIButton(type: .system)
        btDelete.setTitle(textTitle, for: .normal)
        btDelete.setTitleColor(.white, for: .normal)
        btDelete.layer.cornerRadius = 25
        btDelete.clipsToBounds = true
        btDelete.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroudnNavigation)
        btDelete.isHidden = true
        self.view.addSubview(btDelete)
        btDelete.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        return btDelete
    }

    //lấy các dữ liệu hình ảnh
    func FetchPhotos() -> Int{
        let fetchOption = PHFetchOptions()
//        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOption)
        fetchOption.predicate = NSPredicate(format: "title = %@", "đn")
        let fetchResult: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOption)
        if let first = fetchResult.firstObject {
            print("Hai")
            print(fetchResult.count)
        }
        return fetchResult.count
    }
    
    //lấy các dữ liệu của album Favorites
    func fetchFavorties(){
        let fetchOption = PHFetchOptions()
        fetchOption.predicate = NSPredicate(format: "title = %@", "đn")
        let fetchResult: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOption)
        //Nếu tìm thấy
        if let found = fetchResult.firstObject {
            print("Một")
        }
    }
    
}
extension UICollectionReusableView {
    //setup & Config Header Label
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


