//
//  Home.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/14/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import SnapKit

class Home: UIViewController {

    var modelText = ModelText()
    var viewTitle = UIView()
    let viewPercent = UIView()
    var collec: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupViews()
    }
    
    func setupViews(){
        setupViewTitle()
        setupViewPercent()
        setupCollect()
    }
    
    func setupCollect(){
        let layout = UICollectionViewFlowLayout()
        collec = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(collec)
        
//        collec.translatesAutoresizingMaskIntoConstraints = false
//        collec.topAnchor.constraint(equalTo: self.viewPercent.bottomAnchor, constant: 0).isActive = true
//        collec.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        collec.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
//        collec.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2).isActive = true
        collec.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewPercent.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.right.equalTo(self.view)
            make.height.equalTo(view.snp.height).dividedBy(2)
        }
        
        collec.backgroundColor = .white
        collec.delegate = self
        collec.dataSource = self
        collec.register(HomeCell.self, forCellWithReuseIdentifier: "cell")
        collec.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
    
    func setupViewTitle(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.view.addSubview(viewTitle)
//        viewTitle.backgroundColor = UIColor.orange
//
//        viewTitle.translatesAutoresizingMaskIntoConstraints = false
//        viewTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
//        viewTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        viewTitle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
//        viewTitle.heightAnchor.constraint(equalToConstant: 120).isActive = true
//
        UIApplication.shared.statusBarStyle = .lightContent
        let texttitle = UILabel()
        texttitle.text = modelText.textTitleHome
        texttitle.font = UIFont.boldSystemFont(ofSize: 30)
        texttitle.textColor = .white
        viewTitle.addSubview(texttitle)

//        texttitle.translatesAutoresizingMaskIntoConstraints = false
//        texttitle.bottomAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: -15).isActive = true
//        texttitle.leftAnchor.constraint(equalTo: viewTitle.leftAnchor, constant: 15).isActive = true
//        texttitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        texttitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
  
        texttitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.viewTitle.snp.bottom).offset(-15)
            make.left.equalTo(self.viewTitle.snp.left).offset(15)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }

        let btSetting = UIButton(type: .custom)
        let imgSet = UIImage(named: modelText.imgSetting)?.withRenderingMode(.alwaysTemplate)
        btSetting.setImage(imgSet, for: .normal)
        btSetting.tintColor = .white
//        btSetting.tintColor = .white
        viewTitle.addSubview(btSetting)

//        btSetting.translatesAutoresizingMaskIntoConstraints = false
//        btSetting.rightAnchor.constraint(equalTo: viewTitle.rightAnchor, constant: -15).isActive = true
//        btSetting.centerYAnchor.constraint(equalTo: texttitle.centerYAnchor, constant: 0).isActive = true
//        btSetting.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        btSetting.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btSetting.snp.makeConstraints { (make) in
            make.right.equalTo(viewTitle).offset(-15)
            make.centerY.equalTo(texttitle.snp.centerY)
            make.width.height.equalTo(40)
        }

        let viewSeparator = UIView()
        viewSeparator.backgroundColor = .darkGray
        viewTitle.addSubview(viewSeparator)

//        viewSeparator.translatesAutoresizingMaskIntoConstraints = false
//        viewSeparator.bottomAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 0).isActive = true
//        viewSeparator.centerXAnchor.constraint(equalTo: viewTitle.centerXAnchor, constant: 0).isActive = true
//        viewSeparator.widthAnchor.constraint(equalTo: viewTitle.widthAnchor, constant: -30).isActive = true
//        viewSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        viewSeparator.snp.makeConstraints { (make) in
            make.bottom.centerX.equalTo(viewTitle)
            make.width.equalTo(viewTitle.snp.width).offset(-30)
            make.height.equalTo(1)
        }
        
        guard let size = self.navigationController?.navigationBar.frame else { return }
        viewTitle.frame = CGRect(x: 0, y: -20, width: size.width, height: size.height + 20)
        viewTitle.backgroundColor = .orange
        self.navigationController?.navigationBar.addSubview(viewTitle)
    }
    
    func setupViewPercent(){
        guard let size = self.navigationController?.navigationBar.frame else { return }
        viewPercent.backgroundColor = .red
        self.view.addSubview(viewPercent)
        
//        viewPercent.translatesAutoresizingMaskIntoConstraints = false
//        viewPercent.topAnchor.constraint(equalTo: self.view.topAnchor, constant: size.height + 20).isActive = true
//        viewPercent.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        viewPercent.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
//        viewPercent.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewPercent.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(size.height + 20)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        let txtPercent = UILabel()
        txtPercent.text = modelText.txtPercent
        txtPercent.font = UIFont.systemFont(ofSize: 50)
        txtPercent.adjustsFontSizeToFitWidth = true
        txtPercent.textAlignment = .right
        txtPercent.textColor = .white
//        txtPercent.lineBreakMode = .byCharWrapping
        txtPercent.sizeToFit()
//        txtPercent.minimumScaleFactor = 100
        viewPercent.addSubview(txtPercent)
        
//        txtPercent.translatesAutoresizingMaskIntoConstraints = false
//        txtPercent.centerXAnchor.constraint(equalTo: self.viewPercent.centerXAnchor, constant: 0).isActive = true
//        txtPercent.heightAnchor.constraint(equalTo: self.viewPercent.heightAnchor, multiplier: 1/2).isActive = true
//        txtPercent.centerYAnchor.constraint(equalTo: self.viewPercent.centerYAnchor, constant: 0).isActive = true
//        txtPercent.widthAnchor.constraint(equalToConstant: 100).isActive = true
        txtPercent.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
            make.width.equalTo(100)
        }
        
        let percent = UILabel()
        percent.text = modelText.percent
        percent.textAlignment = .left
        percent.font = UIFont.systemFont(ofSize: 20)
        percent.textColor = .white
        viewPercent.addSubview(percent)
        
//        percent.translatesAutoresizingMaskIntoConstraints = false
//        percent.topAnchor.constraint(equalTo: txtPercent.topAnchor, constant: 0).isActive = true
//        percent.leftAnchor.constraint(equalTo: txtPercent.rightAnchor, constant: 0).isActive = true
//        percent.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        percent.heightAnchor.constraint(equalToConstant: 20).isActive = true
        percent.snp.makeConstraints { (make) in
            make.top.equalTo(txtPercent)
            make.left.equalTo(txtPercent.snp.right)
            make.width.height.equalTo(20)
        }
        
        let textLeft = UILabel()
        textLeft.text = modelText.txtStorage
        textLeft.font = UIFont.systemFont(ofSize: 14)
        textLeft.numberOfLines = 2
        textLeft.textAlignment = .right
        viewPercent.addSubview(textLeft)
        
//        textLeft.translatesAutoresizingMaskIntoConstraints = false
//        textLeft.rightAnchor.constraint(equalTo: percent.leftAnchor, constant: -100).isActive = true
//        textLeft.topAnchor.constraint(equalTo: percent.topAnchor, constant: 0).isActive = true
//        textLeft.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        textLeft.heightAnchor.constraint(equalTo: self.viewPercent.heightAnchor , multiplier: 1/2).isActive = true
        textLeft.snp.makeConstraints { (make) in
            make.right.equalTo(percent.snp.left).offset(-100)
            make.top.equalTo(percent)
            make.width.equalTo(100)
            make.height.equalTo(viewPercent).dividedBy(2)
        }
        
        let textRight = UILabel()
        textRight.text = modelText.txtGB
        textRight.font = UIFont.systemFont(ofSize: 14)
        textRight.numberOfLines = 2
        viewPercent.addSubview(textRight)
        
//        textRight.translatesAutoresizingMaskIntoConstraints = false
//        textRight.leftAnchor.constraint(equalTo: percent.rightAnchor, constant: 0).isActive = true
//        textRight.topAnchor.constraint(equalTo: percent.topAnchor, constant: 0).isActive = true
//        textRight.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        textRight.heightAnchor.constraint(equalTo: self.viewPercent.heightAnchor , multiplier: 1/2).isActive = true
        textRight.snp.makeConstraints { (make) in
            make.left.equalTo(percent.snp.right)
            make.top.equalTo(percent)
            make.width.equalTo(100)
            make.height.equalTo(viewPercent).dividedBy(2)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewTitle.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        viewTitle.isHidden = false
    }


}
extension Home: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var arrayIMG = ["photo", "video", "contact", "location" ]
        let cell = collec.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCell
        cell.img.image = UIImage(named: arrayIMG[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 60) / 2, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var arrayVC = [Photo(), Videos(), Contacts(), Location()]
        let scr = arrayVC[indexPath.row]
        self.navigationController?.pushViewController(scr, animated: true)
    }
    
}
