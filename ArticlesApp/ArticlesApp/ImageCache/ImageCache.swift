//
//  ImageCache.swift
//  ArticlesApp
//


import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
