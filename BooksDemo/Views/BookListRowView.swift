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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            Text(isbn)
        }
    }
}

struct BookListRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookListRowView(title: "Test Book", isbn: "Test isbn")
    }
}
