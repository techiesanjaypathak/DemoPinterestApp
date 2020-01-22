//
//  PinterestRequests.swift
//  PinterestLikeApp
//
//  Created by SanjayPathak on 17/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation
typealias AlbumResponse = (AnyObject) -> Void

protocol AlbumServiceRequestType {
    @discardableResult func getAlbumList(apiQueryModel: AlbumAPIQueryParamModel, completion: @escaping AlbumResponse) -> URLSessionDataTask?
}

struct AlbumServiceRequests: AlbumServiceRequestType {
    
    @discardableResult func getAlbumList(apiQueryModel: AlbumAPIQueryParamModel, completion: @escaping AlbumResponse) -> URLSessionDataTask? {
        let contactRequestModel = APIRequestModel(api: AlbumAPI.getAlbumList(apiQueryModel))
        return WebserviceHelper.requestAPI(apiModel: contactRequestModel) { response in
//            switch response {
//            case .success(let serverData):
//                JSONResponseDecoder.decodeFrom(serverData, returningModelType: [AlbumElement].self, completion: { (albumElementsResponse, error) in
//                    if let parserError = error {
//                        completion(.failure(parserError))
//                        return
//                    }
//
//                    if let albumElementsResponse = albumElementsResponse {
//                        completion(.success(albumElementsResponse))
//                        return
//                    }
//                })
//            case .failure(let error):
//                completion(.failure(error))
//            }
            if response is Error {
                completion(response)
            } else if response is Data {
                JSONResponseDecoder.decodeFrom(response as! Data, returningModelType: [AlbumElement].self, completion: { (albumElementsResponse, error) in
                    if let parserError = error {
                        completion(parserError as AnyObject)
                        return
                    }
                    
                    if let albumElementsResponse = albumElementsResponse {
                        completion(albumElementsResponse as AnyObject)
                        return
                    }
                })
            }
        }
    }
}
