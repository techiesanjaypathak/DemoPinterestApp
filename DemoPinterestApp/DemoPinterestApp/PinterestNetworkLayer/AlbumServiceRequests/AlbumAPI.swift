//
//  PinterestAPIs.swift
//  PinterestLikeApp
//
//  Created by SanjayPathak on 17/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

struct AlbumAPIQueryParamModel {
}

///  This API will hold all APIs related to Pinterest
enum AlbumAPI {
    case getAlbumList(AlbumAPIQueryParamModel)
}

extension AlbumAPI: APIProtocol {
    func httpMthodType() -> HTTPMethodType {
        var methodType = HTTPMethodType.get
        switch self {
        case .getAlbumList(_):
            methodType = .get
        }
        return methodType
    }

    func apiEndPath() -> String {
        var apiEndPath = ""
        switch self {
        case .getAlbumList(_):
            apiEndPath += ""
        }
        return apiEndPath
    }

    func apiBasePath() -> String {
        switch self {
        case .getAlbumList(_):
            return WebServiceConstants.baseURL
        }
    }
}
