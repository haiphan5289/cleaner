//
//  Contacts.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {

    var collectData: UICollectionView!
    var collectHandleData: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
        setupViews()
    }
    
    func setupViews(){
        self.setupNavigation(text: "Contacts", isPhotoDetail: false)
        setupViewData()
        setupHandleViewData()
    }
    
    func setupHandleViewData(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: 10, height: 50)
        collectHandleData = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectHandleData.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
        self.view.addSubview(collectHandleData)
        
        collectHandleData.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.collectData.snp.bottom)
        }
        collectHandleData.delegate = self
        collectHandleData.dataSource = self
        collectHandleData.register(ContactsHandleDataCell.self, forCellWithReuseIdentifier: "cell")
        collectHandleData.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectHandleData.register(ContactsHeader.self,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader ,
                                   withReuseIdentifier: "ContactHeader")
    }
    
    func setupViewData(){
        let layout = UICollectionViewFlowLayout()
        collectData = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectData.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
        self.view.addSubview(collectData)
        
        guard let size = self.navigationController?.navigationBar.frame else { return }
        collectData.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(size.height + 20)
            make.height.equalTo(120)
        }
        collectData.delegate = self
        collectData.dataSource = self
        collectData.register(ContactsDataCell.self, forCellWithReuseIdentifier: "cell")
        collectData.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }

}
extension ContactsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectData {
            return 1
        }
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectData {
            return 2
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectData {
            let cell = collectData.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContactsDataCell

            return cell
        }
        let cell = collectHandleData.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContactsHandleDataCell

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectData {
            return CGSize(width: self.view.frame.width - 20, height: 50)
        }
        return CGSize(width: (self.view.frame.width - 50) / 3, height: self.view.frame.height / 4)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var arrayHeader = ModelText.share.arrayTxtHeader(header1: "Duplicate", header2: "No Information")
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectHandleData.dequeueReusableSupplementaryView(ofKind: kind ,
                                                                            withReuseIdentifier: "ContactHeader",
                                                                            for: indexPath) as! ContactsHeader
            header.txtContactHeader.text = arrayHeader[indexPath.section]
            return header
        default:
             assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectData {
            let arrayVC = [AllContacts(), AllContacts()]
            let src = arrayVC[indexPath.row]
            self.navigationController?.pushViewController(src, animated: true)
        }
    }
    
}
