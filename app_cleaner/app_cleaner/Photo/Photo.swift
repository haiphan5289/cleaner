//
//  Photo.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/16/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class Photo: UIViewController {

    let collectionViewHeaderFooterReuseIdentifier = "MyHeaderFooterClass"
    var modelText = ModelText()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        implementCode()
        
    }
    func implementCode(){
        self.setupNavigation(text: "Photos", isPhotoDetail: false)
        setupCollection()
        self.fetchFavorties()
    }
    
    func arrayDataPhotos() -> [Int]{
        //array label
        var arrayLabel: [Int] = [Int]()
        let countPhotos = self.FetchPhotos()
        arrayLabel.append(countPhotos)
        arrayLabel.append(0)
        arrayLabel.append(0)
        arrayLabel.append(0)
        return arrayLabel
    }
    
    func setupCollection(){
        let collect = self.setupCollectionExtension(isHeader: true, spacingItem: 0)
        collect.delegate = self
        collect.dataSource = self
        collect.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
        collect.register(MyHeaderFooterClass.self ,
                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                         withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier)
        collect.register(MyHeaderFooterClass.self ,
                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                         withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier)
        collect.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    

}
extension Photo: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return 2 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //array text
        var arrayCell = modelText.arrayTxtCell()
        var arrayLB = self.arrayDataPhotos()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        cell.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundCell)
        if indexPath.section == 0 {
            cell.txtCell.text = String(arrayLB[indexPath.row])
        }
        else {
            cell.txtCell.text = "Hai"
        }
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var arraytxtHeader = modelText.arrayTxtHeader(header1: "Duplicate",
                                                      header2: "Animate")
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier,
                                                                             for: indexPath) as! MyHeaderFooterClass
            headerView.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
            headerView.txtHeader.text = arraytxtHeader[indexPath.section]
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier,
                                                                             for: indexPath) as! MyHeaderFooterClass
            return footerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 60) / 2, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let arrayPhotoVC = [PhotoDetailVC(), PhotoDetailVC(), PhotoDetailVC(), PhotoDetailVC()]
        let scr = arrayPhotoVC[indexPath.row]
        self.navigationController?.pushViewController(scr, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 50, height: 180.0)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: 60.0, height: 30.0)
//    }
}
