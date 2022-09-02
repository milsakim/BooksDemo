//
//  BookListView.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/24.
//

import SwiftUI

struct BookListView: View {
    @StateObject private var bookListViewModel: BookListViewModel = .init()
    @State private var searchKeyword: String = ""
    
    var body: some View {
        ScrollView {
            if !bookListViewModel.books.isEmpty {
                LazyVStack(alignment: .leading) {
                    ForEach(bookListViewModel.books, id: \.isbn13) { book in
                        NavigationLink(destination: BookDetailView(isbn: book.isbn13)) {
                            BookListRowView(title: book.title, isbn: book.isbn13, urlString: book.image)
                        }
                    }
                    
                    Color.clear
                        .onAppear {
                            print("--- clear view appeared ---")
                            bookListViewModel.fetchMoreBooks(with: searchKeyword)
                        }
                }
            }
            else if bookListViewModel.books.isEmpty && !bookListViewModel.isFetchingPage {
                Text("No Search Result")
            }
            
            if bookListViewModel.isFetchingPage {
                ProgressView()
            }
        }
        .searchable(text: $searchKeyword)
        .onChange(of: searchKeyword) { keyword in
            print("--- keyword on change: \(keyword) \(searchKeyword)---")
            bookListViewModel.setSearchKeyword(to: keyword)
        }
        .onSubmit(of: .search) {
            print("--- submit!!!!!! ---")
            bookListViewModel.setSearchKeyword(to: searchKeyword)
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
