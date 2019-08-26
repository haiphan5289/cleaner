//
//  PhotoDetailVC.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/19/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import Photos
import RxCocoa
import RxSwift

class PhotoDetailVC: UIViewController {
    
    private var images: [UIImage] = [UIImage]()
//    var numberCurrent = Variable(0)
    var btDelete: UIButton!
    var increase = 0
    var arrayIndex: [Int] = [Int]()
    var collect: UICollectionView!
    var btClean: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    func setupViews(){
        let bag = DisposeBag()
        self.setupNavigation(text: "Photos", isPhotoDetail: true)
        setupCollect()
        //call method setupDeleteButton.
        btDelete = self.setupDeleteButton(textTitle: "Delete " + "\(increase)" + " Photo")
        btDelete.addTarget(self, action: #selector(deletePhotos), for: .touchUpInside)
        //Dùng rx để lắng nghe su thây đổi của biến
//        numberCurrent.asObservable().subscribe(onNext: {
//            self.btDelete.setTitle("Delete " + "\($0)" + " Photo", for: .normal)
//        })
        setupCleanButtonPhotoVC()
    }
    
    @objc func deletePhotos(){
        deletePhotoLibrary()
    }
    
    func setupCleanButtonPhotoVC(){
        btClean = self.setupClearButton(title: "Clear")
    }

    
    func setupCollect(){
        collect = self.setupCollectionExtension(isHeader: false, spacingItem: 5)
        collect.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
        collect.delegate = self
        collect.dataSource = self
        collect.register(PhotoDetailCell.self, forCellWithReuseIdentifier: "cell")
        //dùng hàm  DispatchQueue.main.async để reload
        self.fetchPhotos()
    }

    //Xoá đi ảnh trong libarry
    func deletePhotoLibrary(){
        var fetchOptions: PHFetchOptions = PHFetchOptions()
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        var fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        var arrayDeletePhotos: [PHAsset] = [PHAsset]()
        for i in arrayIndex {
            arrayDeletePhotos.append(fetchResult[i])
            self.images.remove(at: i)
        }
//        let arrayToDelete = NSArray(object: fetchResult[2])
//        PHPhotoLibrary.shared().performChanges({
//            PHAssetChangeRequest.deleteAssets(arrayDeletePhotos as NSFastEnumeration)
//            DispatchQueue.main.async {
//                self.collect.reloadData()
//            }
//        }, completionHandler: nil)
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(arrayDeletePhotos as NSFastEnumeration)
        }) { (success, err) in
            if err != nil {
                print("\(err?.localizedDescription)")
            }
            else {
                DispatchQueue.main.async {
                    self.collect.reloadData()
                }
            }
        }
//        if (fetchResult.lastObject != nil) {
        
//            var lastAsset: PHAsset = fetchResult.lastObject as! PHAsset
            
//            let arrayToDelete = NSArray(object: fetchResult[2])
//            PHPhotoLibrary.shared().performChanges( {
//                PHAssetChangeRequest.deleteAssets(arrayToDelete)},
//                                                                completionHandler: {
//                                                                    success, error in
//                                                                    NSLog("Finished deleting asset. %@", (success ? "Success" : error))
//
//            })
//    }
    
    }
    
    //lấy ảnh từ library lên viewcontroller
    func fetchPhotos() {
        // Sort the images by descending creation date and fetch the first 3
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        //        fetchOptions.fetchLimit = 3
        
        // Fetch the image assets
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        //get ìnfor fetchResult
        print(fetchResult[2].location?.distance(from: CLLocation(latitude: 10.76592833, longitude: 106.69348833)))
        print(fetchResult[2].creationDate)
        print(fetchResult[2].location)
        // If the fetch result isn't empty,
        // proceed with the image request
//                if fetchResult.count > 0 {
//                    let totalImageCountNeeded = 300 // <-- The number of images to fetch
//                    fetchPhotoAtIndex(0, totalImageCountNeeded, fetchResult)
//
//                }
        //        let totalImageCountNeeded = 300 // <-- The number of images to fetch
        
        if fetchResult.count > 0 {
            self.fetchPhotoAtIndex(0, fetchResult)
        }
    
    }
    
    //Hàm để lấy tất cả hỉnh trong library
    // Repeatedly call the following method while incrementing
    // the index until all the photos are fetched
    func fetchPhotoAtIndex(_ index:Int,_ fetchResult: PHFetchResult<PHAsset>) {
        // Note that if the request is not set to synchronous
        // the requestImageForAsset will return both the image
        // and thumbnail; by setting synchronous to true it
        // will return just the thumbnail
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        
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
            //hàm này dùng để filter hết tất cả hình trong library
            if index + 1 < fetchResult.count  {
                self.fetchPhotoAtIndex(index + 1, fetchResult)
            } else {
                // Else you have completed creating your array
                print("Completed array: \(self.images)")
                self.collect.reloadData()
                
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
        cell.indexIMG = indexPath.row
        //bắt event tap
        //khi tap sẽ thây đổi thuôc tinh của cell và cách thuộc tính khác
        btClean.rx.tap
            .subscribe(onNext: {
                cell.bt.isSelected = false
                cell.bt.setImage(nil, for: .normal)
                self.increase = 0
                self.arrayIndex = []
                self.btDelete.isHidden = true
                
            })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 15) / 4, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
extension PhotoDetailVC: checkButtonDelegate {

    //nhận event của ham handleSelect để xử lý
    func CheckButton(count: Int, index: Int, isCheckRemove: Bool)  {
        increase += count
        if isCheckRemove {
            var arrayIndexTemp: [Int] = [Int]()
            for i in arrayIndex {
                if index != i {
                    arrayIndexTemp.append(i)
                }
            }
            arrayIndex = arrayIndexTemp
        }
        else {
            arrayIndex.append(index)
        }
//        numberCurrent.value = increase
        if increase > 0 {
            btDelete.isHidden = false
            //Change text khi tăng số lần chọn.
            btDelete.setTitle("Delete " + "\(increase)" + " Photo", for: .normal)
        }
        else {
            btDelete.isHidden = true
        }

    }
}
