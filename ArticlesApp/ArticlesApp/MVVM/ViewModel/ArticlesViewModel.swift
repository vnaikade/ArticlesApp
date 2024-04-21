//
//  ArticlesViewModel.swift
//  ArticlesApp
//
//  Created by Vinay Naikade on 17/04/24.
//

import Foundation
import Combine

class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var error: NetworkError? = nil
    
    init(withError: Bool = false) {
        self.fetchMediaArticles(limit: withError ? 200 : 100)
    }
    
    func fetchMediaArticles(limit: Int = 100) {
        Task {
            do {
                let mediaList = try await NetworkManager().callAPI(withRequest: MediaCoverageRequest(limit: limit), model: [Article].self)
                DispatchQueue.main.async { [weak self] in
                    self?.error = nil
                    self?.articles = mediaList
                }
            } catch let error as NetworkError {
                processError(error: error)
            }
        }
    }
    
    func processError(error: NetworkError) {
        DispatchQueue.main.async { [weak self] in
            self?.error = error
        }
    }
    
    static func imageURL(for article: Article, with quality: Int = 20) -> URL? {
        return article.thumbnail.imageURL(with: quality)
    }
}
