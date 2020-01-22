//
//  ImageDownloader.swift
//  DemoPinterestApp
//
//  Created by SanjayPathak on 22/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import UIKit

struct Delegated<Input> {
    
    private(set) var callback: ((Input) -> Void)?
    
    // making sure there is no retain cycle with weak self
    mutating func delegate<Object : AnyObject>(to object: Object, with callback: @escaping (Object, Input) -> Void) {
        self.callback = { [weak object] input in
            guard let object = object else {
                return
            }
            callback(object, input)
        }
    }
}

class ImageDownloader {
    
    var didDownload = Delegated<UIImage>()
    
    func downloadImage(forURL url: URL, indexPath: IndexPath?) {
        ImageDownloadManager.shared.downloadImage(withURL: url, indexPath: indexPath) { (image, url, indexPath, error) in
            if let img = image {
                self.didDownload.callback?(img)
            }
        }
    }
}
