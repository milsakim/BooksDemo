//
//  BookListView.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/24.
//

import SwiftUI

struct BookListView: View {
    @StateObject private var bookListViewModel: BookListViewModel = .init()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(bookListViewModel.books, id: \.isbn13) { book in
                    NavigationLink(destination: BookDetailView()) {
                        BookListRowView(title: book.title, isbn: book.isbn13, urlString: book.image)
                            .onAppear {
                                print("--- row: \(book.title) ---")
                                bookListViewModel.fetchBooksIfNeeded(currentBook: book)
                            }
                    }
                }
            }
            
            if bookListViewModel.isFetchingPage {
                ProgressView()
            }
        }
        .onAppear {
            print("--- Appear ---")
            bookListViewModel.fetchBooksIfNeeded(currentBook: nil)
        }
        
        /*
        VStack {
            List(bookListViewModel.books, id: \.isbn13) { book in
                NavigationLink(destination: BookDetailView()) {
                    BookListRowView(title: book.title, isbn: book.isbn13)
                        .onAppear {
                            print("--- row: \(book.title) ---")
                            bookListViewModel.fetchBooksIfNeeded(currentBook: book)
                        }
                }
            }
            .listStyle(.plain)
            .onAppear {
                print("--- Appear ---")
                bookListViewModel.fetchBooksIfNeeded(currentBook: nil)
            }
            
            if bookListViewModel.isFetchingPage {
                ProgressView()
            }
        }
        */
    }
}

struct BookListView_Previews: PreviewProvider {
    @StateObject static var bookListViewModel: BookListViewModel = .init()
    
    static var previews: some View {
        BookListView()
    }
}
