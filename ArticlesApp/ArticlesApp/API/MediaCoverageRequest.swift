//
//  MediaCoverageRequest.swift
//  ArticlesApp
//


import Foundation

class MediaCoverageRequest: APIRequestGenerator {
    var baseURL: String
    var method: HTTPMethod
    var body: Data?
    var timeOut: TimeInterval

    init(limit: Int) {
        self.baseURL = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=\(limit)"
        self.method = .get
        self.timeOut = 60
    }
}
