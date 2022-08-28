//
//  BookDetailView.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/24.
//

import SwiftUI

struct BookDetailView: View {
    var body: some View {
        Text("Book Detail")
            .toolbar {
                Button(action: {
                    print("--- edit button tapped ---")
                }) {
                    Text("Edit")
                }
            }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
