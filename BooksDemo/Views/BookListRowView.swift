//
//  BookListRowView.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/24.
//

import SwiftUI

struct BookListRowView: View {
    var title: String
    var isbn: String
    var urlString: String
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: urlString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 120)
            
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                Text(isbn)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct BookListRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookListRowView(title: "Test Book", isbn: "Test isbn", urlString: "https://itbook.store/img/books/9781118342329.png")
    }
}
