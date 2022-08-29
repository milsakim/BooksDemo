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
    var uiImage: UIImage?
    
    var body: some View {
        HStack(alignment: .center) {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
            }
            else {
                Image(systemName: "x.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .background(Color.red)
                Text(isbn)
            }
            
            Spacer()
        }
    }
}

struct BookListRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookListRowView(title: "Test Book", isbn: "Test isbn")
    }
}
