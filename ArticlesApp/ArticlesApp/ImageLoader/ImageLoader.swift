//
//  ImageLoader.swift
//  ArticlesApp
//


import SwiftUI
import Combine

enum ImageLoaderStatus {
    case none, loading, error, success
}

@MainActor class ImageLoader: ObservableObject {
    
    @Published public var newImage: UIImage?
    @Published private(set) var status: ImageLoaderStatus = .none {
        didSet {
            if status == .error {
                setPlaceholderImage()
            }
        }
    }
    private(set) var placeholderImage: UIImage?
    
    init(with url: URL?, placeholderImage: UIImage? = nil) {
        self.placeholderImage = placeholderImage
        downloadImage(with: url)
    }
    
    private func setPlaceholderImage() {
        newImage = placeholderImage ?? UIImage(named: "placeholder")
    }
    
    private func setAlreadyDownloadedImage(with url: URL?) -> Bool {
        guard let imageURL = url, let image = ImageUtility.getCachedImage(with: imageURL) else {
            return false
        }
        newImage = image
        return true
    }
    
    private func startDownloadingImage(with url: URL?) {
        guard ImageUtility.validImageURL(url: url) else {
            status = .error
            return
        }
        guard NetworkUtility.isConnectedToNetwork() else {
            status = .error
            return
        }
        status = .loading
        Task {
            do {
                if let image = try await ImageUtility.downloadImage(with: url) {
                    newImage = image
                    status = .success
                }
            } catch let error {
                print("Caught error: \(error.localizedDescription) while downloading an image from url \(url?.absoluteString ?? "")")
                status = .error
            }
        }
    }
    
    private func downloadImage(with url: URL?) {
        if setAlreadyDownloadedImage(with: url) {
            status = .success
            return
        }
        startDownloadingImage(with: url)
    }
}
