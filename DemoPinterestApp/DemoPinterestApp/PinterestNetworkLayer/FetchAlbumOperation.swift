//
//  FetchAlbumOperation.swift
//  DemoPinterestApp
//
//  Created by SanjayPathak on 22/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation
class FetchAlbumOperation : BaseAsyncOperation {
    
    typealias SBlock = ([AlbumElement]) -> Void
    typealias FBlock = (Error) -> Void
    
    private var fetchSession: URLSessionDataTask?
    
    var successBlock : SBlock?
    var failureBlock : FBlock?
    
    override func main() {
        guard isCancelled == false else{
            self.state = .Finished
            return
        }
        self.state = .Executing
        let queryModel = AlbumAPIQueryParamModel()
        fetchSession = AlbumServiceRequests().getAlbumList(apiQueryModel: queryModel) { [weak self] apiResult in
            self?.fetchSession = nil
            if apiResult is Error {
                if let failureBlock = self?.failureBlock {
                    failureBlock(apiResult as! Error)
                }
            } else {
                if let successBlock = self?.successBlock {
                    successBlock(apiResult as! [AlbumElement])
                }
            }
//            switch apiResult {
//            case .success(let album):
//                if let successBlock = self?.successBlock {
//                    successBlock(album)
//                }
//            case .failure(let error):
//                if let failureBlock = self?.failureBlock {
//                    failureBlock(error)
//                }
//                debugPrint(error)
//            }
            self?.state = .Finished
        }
        
    }
    
}
