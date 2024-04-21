//
//  MediaCoverage.swift
//  ArticlesApp
//


import Foundation

struct Article: Codable {
    let id: String
    let title: String
    let language: String
    let thumbnail: Thumbnail
    let mediaType: Int
    let coverageURL: String
    let publishedAt: String
    let publishedBy: String
}

struct Thumbnail: Codable {
    let id: String
    let version: Int
    let domain: String
    let basePath: String
    let key: String
    let qualities: [Int]
    let aspectRatio: Int
    
    func imageURL(with quality: Int) -> URL? {
        let imageQuality = (qualities.firstIndex { $0 == quality } != nil) ? quality : 20
        return URL(string: domain + "/" + basePath + "/" + "\(imageQuality)" + "/" + key)
    }
}
