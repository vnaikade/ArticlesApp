//
//  ImageUtility.swift
//  ArticlesApp
//


import UIKit

class ImageUtility {
    
    static func getKey(from url: String) -> String {
        EncryptionUtility.sha256(url)
    }
    
    static func getCachedImage(with url: URL) -> UIImage? {
        let encryptedKey = getKey(from: url.absoluteString)
        if let image = ImageCache.shared.getImage(forKey: encryptedKey) {
            return image
        } else if let fileExtension = fileExtension(from: url), let imageData = FileUtility.shared.getImageData(forFileName: encryptedKey + fileExtension), let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    static func cacheImage(with data: Data, for url: URL) {
        guard let image = UIImage(data: data) else {
            return
        }
        let encryptedKey = getKey(from: url.absoluteString)
        ImageCache.shared.setImage(image, forKey: encryptedKey)
        guard let fileExtension = fileExtension(from: url) else { return }
        FileUtility.shared.saveImageData(data, forFileName: encryptedKey + fileExtension)
    }
    
    static func fileExtension(from url: URL) -> String? {
        if let fileExtension = url.lastPathComponent.components(separatedBy: ".").last {
            return "." + fileExtension
        }
        return nil
    }
    
    private static func downloadImage(from url: URL) async throws -> Data? {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    @discardableResult
    static func downloadImage(with url: URL?) async throws -> UIImage? {
        guard let url else {
            return nil
        }
        do {
            guard let data = try await downloadImage(from: url) else {
                return nil
            }
            cacheImage(with: data, for: url)
            return getCachedImage(with: url)
        } catch let error {
            throw error
        }
    }
    
    static func validImageURL(url: URL?) -> Bool {
        guard let url, fileExtension(from: url) != nil else {
            return false
        }
        return true
    }
}
