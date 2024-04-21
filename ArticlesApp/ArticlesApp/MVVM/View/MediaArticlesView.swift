//
//  MediaArticlesView.swift
//  ArticlesApp
//


import SwiftUI

struct MediaArticlesView: View {

    @ObservedObject var viewModel = ArticlesViewModel()
    let numberOfColumns: Double = 3
    let spaceBetweenColumns: Double = 5
    
    var body: some View {
        
        GeometryReader(content: { geometry in
            let width = (geometry.size.width - ((numberOfColumns - 1) * spaceBetweenColumns)) / numberOfColumns
            NavigationStack {
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: Int(numberOfColumns)), spacing: spaceBetweenColumns) {
                            ForEach(viewModel.articles, id: \.id) { article in
                                NavigationLink(destination: ArticleDetails(article: article), label: {
                                    ImageView(withImageURL: ArticlesViewModel.imageURL(for: article, with: 20), placeholderImage: nil, imageAspectRatio: .fit, imageSize: CGSize(width: width, height: width))
                                        .frame(width: width, height: width)
                                        .border(.gray)
                                })
                            }
                        }
                        .padding(.horizontal, spaceBetweenColumns)
                    }
                    ZStack {
                        if let error = viewModel.error {
                            ErrorView(errorTitle: error.localizedDescription , viewModel: viewModel)
                        }
                    }
                }
                .padding(.all, 0)
                .navigationTitle(String(localized:"Articles(\(viewModel.articles.count))"))
                .navigationBarTitleDisplayMode(.inline)
            }
        })
    }
}

struct MediaArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        MediaArticlesView()
    }
}


struct ArticleDetails: View {
    
    let article: Article
    
    var body: some View {
        GeometryReader(content: { geometry in
            let height = geometry.size.height * 0.4
            VStack(alignment: .center) {
                ImageView(withImageURL: ArticlesViewModel.imageURL(for: article, with: 40), placeholderImage: nil, imageAspectRatio: .fit, imageSize: CGSize(width: height, height: height))
                    .padding()
                    .border(.gray)
                Text(article.title)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .navigationTitle(String(localized: "Article Details"))
        })
    }
}
