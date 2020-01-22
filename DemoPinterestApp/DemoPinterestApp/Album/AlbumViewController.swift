//
//  ViewController.swift
//  DemoPinterestApp
//
//  Created by SanjayPathak on 22/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import UIKit

final class AlbumViewController : UIViewController,AlbumUpdateDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var dataSource: AlbumDataSource!
    let operationQueue = OperationQueue()
    var footerView:CustomFooterView?
    var numberOfElements = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.register(UINib(nibName: "CustomFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AppConstants.ListConstants.footerViewReuseIdentifier)
        collectionView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellWithReuseIdentifier: AlbumCell.identifier)
        pullToRefresh()
    }
    
    func pullToRefresh() {
        self.dataSource = AlbumDataSource(albumUpdateDelegate: self)
    }
    
    internal func updateUI(forState state:AlbumUIStates){
        switch state {
        case .Loading:
            numberOfElements = 0
            DispatchQueue.main.async {
                self.collectionView.isHidden = true
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
            }
            break
        case .Loaded:
            numberOfElements = (numberOfElements + 10) > self.dataSource.albumViewModel.albumElements.count ? self.dataSource.albumViewModel.albumElements.count : (numberOfElements + 10)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.collectionView.isHidden = false
            }
            break
        default:
            break
        }
    }
}


