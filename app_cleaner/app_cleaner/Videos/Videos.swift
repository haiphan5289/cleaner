//
//  Videos.swift
//  app_cleaner
//
//  Created by HaiPhan on 8/18/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import Photos


class Videos: UIViewController {

    var btClean:UIButton!
    var collect: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = FunctionAll.share.BackGroundColor(typeColor: .backgroundView)
        setupViews()
    }
    
    func setupViews(){
        self.setupNavigation(text: "Videos", isPhotoDetail: false)
        setupCollection()
        FetchVideos()
        
    }

    
    //lấy video từ library
    func FetchVideos(){
        //khai báo biến Request và sort theo creationdate
        let fetchoption = PHFetchOptions()
        fetchoption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        //fetch video
        let fetchresult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.video, options: fetchoption)
        if fetchresult.count > 0 {
            self.FetchVideosAtIndex(0, fetchresult)
        }

    }
    var videos: [AVPlayerItem] = [AVPlayerItem]()
    //hầm để lấy tất cả dũ liệu videos
    func FetchVideosAtIndex(_ index: Int, _ fetchResult: PHFetchResult<PHAsset>){
        //khai báo biến request videos
        
        let requestOptions = PHVideoRequestOptions()
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.deliveryMode = PHVideoRequestOptionsDeliveryMode.highQualityFormat
        
        PHImageManager.default().requestPlayerItem(forVideo: fetchResult.object(at: index), options: requestOptions) { (video, info) in
            if let video = video {
                // Add the returned image to your array
                self.videos += [video]
            }
            
            if index + 1 < fetchResult.count  {
                self.FetchVideosAtIndex(index + 1, fetchResult)
            } else {
//                 Else you have completed creating your array
                print("Completed array: \(self.videos.count)")
                DispatchQueue.main.async {
                    self.collect.reloadData()
                }
            }
        }      

    }
    
    func setupCollection(){
        collect = self.setupCollectionExtension(isHeader: true, spacingItem: 0)
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
            return self.videos.count
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
