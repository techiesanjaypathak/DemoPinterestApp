//
//  AlbumViewModel.swift
//  DemoPinterestApp
//
//  Created by SanjayPathak on 22/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

class AlbumViewModel {
    
    var albumElements: [AlbumElement] = []
    var error : Error? = nil
    
    var updateUIState: ((AlbumUIStates)->())?
    
    func fetchAlbums(withOperationQueue operationQ: OperationQueue){
        
        let fetchAlbumOperation = FetchAlbumOperation()
        
        fetchAlbumOperation.successBlock = { [weak self] albumElements in
            self?.albumElements = albumElements
            if let updateUIState = self?.updateUIState {
                // setting total Pages constant here.. since API is not providing
                updateUIState(.Loaded)
            }
        }
        
        fetchAlbumOperation.failureBlock = { [weak self] error in
            self?.error = error
            if let updateUIState = self?.updateUIState {
                updateUIState(.Failed)
            }
        }
        
        operationQ.addOperations([
            fetchAlbumOperation
            ], waitUntilFinished: false)
    }
    
}
