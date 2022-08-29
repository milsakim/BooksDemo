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
    
    let bookSearchRequestable: BookStoreRequestable = .init()
    
    var searchKeyword: String? = "swift"
    
    private var currentPage: Int = 1 {
        didSet {
            print("--- current page: \(currentPage) ---")
        }
    }
    private var canFetchMorePages: Bool = true
    private var previousSearchKeyword: String?
    
    // MARK: - Deinitialize
    
    deinit {
        print("--- BookListViewModel deinit ---")
    }
    
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
        
        let requestModel: RequestModel = RequestModel(endPoint: BookStoreSearchEndPoint(searchKeyword: keyword, page: currentPage))
        
        bookSearchRequestable.request(requestModel) { result in
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
