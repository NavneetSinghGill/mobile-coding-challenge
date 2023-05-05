//
//  UIImageView+imageDownloader.swift
//  mobile-coding-challenge
//
//  Created by Navneet Singh Gill on 2023-05-03.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageDownloaderImageView: UIImageView {
    var urlToLoad: URL?
}


extension ImageDownloaderImageView {
    
    //Load image through url
    func load(url: URL, completionBlock: (URL) -> () = {_ in }) {
        //Store the url for later comparision
        urlToLoad = url
        
        DispatchQueue.global().async { [weak self] in
            //Load image from cache
            if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
                DispatchQueue.main.async {
                    if let urlToLoad = self?.urlToLoad, urlToLoad == url {
                        self?.image = imageFromCache
                    }
                }
            } else {
                DispatchQueue.global(qos: .background).async {
                    if let data = try? Data(contentsOf: url) {
                        if let imageToCache = UIImage(data: data) {
                            DispatchQueue.main.async { [weak self] in
                                imageCache.setObject(imageToCache, forKey: url as AnyObject)
                                
                                if let urlToLoad = self?.urlToLoad, urlToLoad == url { //This condition lets update image only if imageview is correct
                                    self?.image = imageToCache
                                }
                                
                            }
                        }
                    }
                }
            }
            
        }
    }
    
}
