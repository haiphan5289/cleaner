//
//  Videos.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class Videos: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
        setupViews()
    }
    
    func setupViews(){
        self.setupNavigation(text: "Videos", isPhotoDetail: false)
        setupCollection()
    }
    
    func setupCollection(){
        let collect = self.setupCollectionExtension(isHeader: true, spacingItem: 0)
        collect.register(VideoCell.self, forCellWithReuseIdentifier: "cell")
        collect.register(VideoHeaderFooterClass.self,
                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                         withReuseIdentifier: "VideoHeaderFooterClass")
        collect.delegate = self
        collect.dataSource = self
        
        collect.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
    }
}
extension Videos: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoCell
        cell.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var arrayTxtHeader = ModelText.share.arrayTxtHeader(header1: "10 - 100MB",
                                                            header2: "Other")
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "VideoHeaderFooterClass",
                                                                         for: indexPath) as! VideoHeaderFooterClass
            header.lb.text = arrayTxtHeader[indexPath.section]
            return header
        default:
            assert(false, "Unexpected element kind")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 60) / 3, height: 100)
    }
    
}
