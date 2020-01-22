//
//  AlbumDataSource.swift
//  DemoPinterestApp
//
//  Created by SanjayPathak on 22/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

enum AlbumUIStates {
    case Loading
    case Loaded
    case Failed
    case Cancelled
}

protocol AlbumUpdateDelegate : class {
    func updateUI(forState state:AlbumUIStates)
}

class AlbumDataSource {
    weak var albumUpdateDelegate : AlbumUpdateDelegate? = nil
    var operationQueue = OperationQueue()
    lazy var albumViewModel : AlbumViewModel = {
        return AlbumViewModel()
    }()
    
    init(albumUpdateDelegate : AlbumUpdateDelegate?) {
        self.albumUpdateDelegate = albumUpdateDelegate
        configureAlbumViewModel()
        populateAlbum()
    }
    
    func populateAlbum(){
        ImageDownloadManager.shared.cancelAll()
        self.albumViewModel.albumElements.removeAll()
        self.albumUpdateDelegate?.updateUI(forState: .Loading)
        albumViewModel.fetchAlbums(withOperationQueue: operationQueue)
    }
    
    private func configureAlbumViewModel(){
        // bindAlbumViewModelWithView
        albumViewModel.updateUIState = { [weak self] state in
            self?.albumUpdateDelegate?.updateUI(forState: state)
        }
    }
    
    func albumElementForIndexPath(indexPath: IndexPath) -> AlbumElement {
        return albumViewModel.albumElements[(indexPath as NSIndexPath).row]
    }
}
