//
//  BookListViewModel.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/24.
//

import Foundation
import Combine

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isFetchingPage: Bool = false
    
    var bookSearchRequestable: BookStoreRequestable = BookStoreRequestable(searchKeyword: "data")
    
    private var searchKeyword: String? = "data"
    
    private var currentPage: Int = 1 {
        didSet {
            print("--- current page: \(currentPage) ---")
            bookSearchRequestable.pageIndex = currentPage
            
        }
    }
    private var canFetchMorePages: Bool = true
    private var previousSearchKeyword: String?
    
    // MARK: - Deinitialize
    
    deinit {
        print("--- BookListViewModel deinit ---")
    }
    
    // MARK: - Setting Search Keyword Related Methods
    
    func setSearchKeyword(to newKeyword: String) {
        guard let searchKeyword = searchKeyword else {
            searchKeyword = newKeyword
            bookSearchRequestable.searchKeyword = newKeyword
            
            fetchMoreBooks(with: newKeyword)
            
            return
        }

        // 현재 키워드와 동일한 경우
        if searchKeyword == newKeyword {
            return
        }
        else {
            self.searchKeyword = newKeyword
            bookSearchRequestable.searchKeyword = newKeyword
            books.removeAll()
            currentPage = 1
            fetchMoreBooks(with: newKeyword)
        }
    }
    
    // MARK: - Data Fetch Related Methods
    
    func fetchBooksIfNeeded(currentBook book: Book?) {
        guard let book = book, let searchKeyword = searchKeyword else {
            fetchMoreBooks(with: searchKeyword!)
            return
        }

        let thresholdIndex = books.index(books.endIndex, offsetBy: -3)
        if books.firstIndex(where: { $0.isbn13 == book.isbn13 }) == thresholdIndex {
            fetchMoreBooks(with: searchKeyword)
        }
    }
    
    func fetchMoreBooks(with keyword: String) {
        guard !isFetchingPage && canFetchMorePages else {
            return
        }
        
        isFetchingPage = true
        
        bookSearchRequestable.request { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.isFetchingPage = false
                    self.currentPage += 1
                    self.books.append(contentsOf: response.books)
                    self.canFetchMorePages = Int(response.total)! > self.books.count
                    
                    print("--- \(self.books.count) ---")
                }
                print("--- response: \(response) ---")
            case .failure(let error):
                print("--- error: \(error) ---")
            }
        }
    }
    
    func clear() {
        
    }
}
