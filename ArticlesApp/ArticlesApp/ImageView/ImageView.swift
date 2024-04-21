//
//  ImageView.swift
//  ArticlesApp
//


import SwiftUI
 
struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    var placeholderImage: UIImage?
    let imageURL: URL?
    let aspectRatio: ContentMode
    let size: CGSize

    init(withImageURL url: URL?, placeholderImage image: UIImage?, imageAspectRatio: ContentMode = .fit, imageSize: CGSize) {
        imageURL = url
        placeholderImage = image
        aspectRatio = imageAspectRatio
        size = imageSize
        imageLoader = ImageLoader(with: url, placeholderImage: placeholderImage)
    }

    public var body: some View {
        VStack {
            if let image = imageLoader.newImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: aspectRatio)
                    .frame(width: size.width, height: size.height)
            }
        }
    }
}
