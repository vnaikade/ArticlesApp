//
//  ErrorView.swift
//  ArticlesApp
//


import SwiftUI

struct ErrorView: View {
    let errorTitle: String
    @ObservedObject var viewModel: ArticlesViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.red)
            .overlay {
                VStack {
                    Text(errorTitle)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Button("Reload Articles") {
                        viewModel.fetchMediaArticles()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
    }
}
