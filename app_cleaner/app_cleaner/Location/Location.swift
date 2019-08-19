//
//  Location.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class Location: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews(){
        self.setupNavigation(text: "Location", isPhotoDetail: false)
        setupCollection()
    }
    
    func setupCollection(){
        let collect = self.setupCollectionExtension(isHeader: false, spacingItem: 0)
        collect.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
        collect.delegate = self
        collect.dataSource = self
        collect.register(LocationCell.self, forCellWithReuseIdentifier: "cell")
        collect.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

}
extension Location: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LocationCell
        cell.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundCell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 60) / 2, height: 150)
    }
    
    
}
