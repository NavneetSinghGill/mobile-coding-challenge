//
//  UIImageView+imageDownloader.swift
//  mobile-coding-challenge
//
//  Created by Navneet Singh Gill on 2023-05-03.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    //Load image through url
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            //Load image from cache
            if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
                DispatchQueue.main.async {
                    self?.image = imageFromCache
                }
            } else {
                if let data = try? Data(contentsOf: url) {
                    if let imageToCache = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageCache.setObject(imageToCache, forKey: url as AnyObject)
                            self?.image = imageToCache
                        }
                    }
                }
            }
            
        }
    }
    
}
