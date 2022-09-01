//
//  BookInformationRowView.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/09/01.
//

import SwiftUI

struct BookInformationRowView: View {
    var title: String
    var content: String
    var alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: alignment) {
            Text("\(title)")
                .font(.caption)
                .foregroundColor(Color.secondary)
            Text("\(content)")
        }
    }
}

struct BookInformationRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookInformationRowView(title: "Title", content: "This is title", alignment: .leading)
    }
}
