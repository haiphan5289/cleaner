//
//  PhotoDetailVC.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/19/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailVC: UIViewController {
    
    var images: [UIImage] = [UIImage]()
    var numberCurrent = 0
    var btDelete: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        self.setupNavigation(text: "Photos", isPhotoDetail: true)
        setupCollect()
        fetchPhotos()
        print(images.count)
    }
    
    func setupCollect(){
        let collect = self.setupCollectionExtension(isHeader: false, spacingItem: 5)
        collect.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
        collect.delegate = self
        collect.dataSource = self
        collect.register(PhotoDetailCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func fetchPhotos() {
        // Sort the images by descending creation date and fetch the first 3
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        //        fetchOptions.fetchLimit = 3
        
        // Fetch the image assets
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        // If the fetch result isn't empty,
        // proceed with the image request
        //        if fetchResult.count > 0 {
        //            let totalImageCountNeeded = 300 // <-- The number of images to fetch
        //            fetchPhotoAtIndex(0, totalImageCountNeeded, fetchResult)
        //
        //        }
        //        let totalImageCountNeeded = 300 // <-- The number of images to fetch
        if fetchResult.count > 0 {
            fetchPhotoAtIndex(0, fetchResult)
        }
    }
    
    // Repeatedly call the following method while incrementing
    // the index until all the photos are fetched
    func fetchPhotoAtIndex(_ index:Int,_ fetchResult: PHFetchResult<PHAsset>) {
        
        // Note that if the request is not set to synchronous
        // the requestImageForAsset will return both the image
        // and thumbnail; by setting synchronous to true it
        // will return just the thumbnail
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        // Perform the image request
        PHImageManager.default().requestImage(for: fetchResult.object(at: index) as PHAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.aspectFill, options: requestOptions, resultHandler: { (image, _) in
            if let image = image {
                // Add the returned image to your array
                self.images += [image]
            }
            // If you haven't already reached the first
            // index of the fetch result and if you haven't
            // already stored all of the images you need,
            // perform the fetch request again with an
            // incremented index
            if index + 1 < fetchResult.count  {
                self.fetchPhotoAtIndex(index + 1, fetchResult)
            } else {
                // Else you have completed creating your array
                print("Completed array: \(self.images)")
            }
        })
    }


}
extension PhotoDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoDetailCell
        //khi click sẽ gửi 1 event là viewcontroller này đang có delegate protocol
        //để nhận được sự kiện từ hàm CheckButton của checkButtonDelegate trong hàm handleSelect
        cell.checkDelegate = self
        cell.imgPhotoDetailCell.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 15) / 4, height: 100)
    }
    
}
extension PhotoDetailVC: checkButtonDelegate {
    //nhận event của ham handleSelect để xử lý
    func CheckButton(count: Int) {
        numberCurrent += count
        print(numberCurrent)
        btDelete = UIButton(type: .system)
        btDelete.setTitle("Delete Photo", for: .normal)
        btDelete.setTitleColor(.white, for: .normal)
        btDelete.layer.cornerRadius = 25
        btDelete.clipsToBounds = true
        btDelete.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroudnNavigation)
        if numberCurrent > 0 {
            btDelete.isHidden = false
            self.view.addSubview(btDelete)
            
            btDelete.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-50)
                make.width.equalTo(200)
                make.height.equalTo(50)
            }
        }
        else {
            btDelete.isHidden = true
            btDelete.isEnabled = true
        }

    }
    
    
}
