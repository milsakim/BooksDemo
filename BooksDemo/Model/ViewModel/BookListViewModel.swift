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
    
    private var searchKeyword: String?
    
    private var currentPage: Int = 0
    private var canFetchMorePages: Bool = true
    private var previousSearchKeyword: String?
    
    // MARK: - Deinitialize
    
    deinit {
        print("--- BookListViewModel deinit ---")
    }
    
    // MARK: - Setting Search Keyword Related Methods
    
    func setSearchKeyword(to newKeyword: String) {
        guard !newKeyword.isEmpty else {
            books.removeAll()
            currentPage = 0
            isFetchingPage = false
            canFetchMorePages = true
            return
        }
        
        guard let searchKeyword = searchKeyword else {
            searchKeyword = newKeyword
            
            fetchMoreBooks(with: newKeyword)
            
            return
        }

        // 현재 키워드와 동일한 경우
        if searchKeyword == newKeyword {
            return
        }
        else {
            self.searchKeyword = newKeyword
            books.removeAll()
            currentPage = 0
            isFetchingPage = false
            canFetchMorePages = true
            fetchMoreBooks(with: newKeyword)
        }
    }
    
    // MARK: - Data Fetch Related Methods
    
    func fetchMoreBooks(with keyword: String) {
        guard !isFetchingPage && canFetchMorePages else {   
            return
        }
        
        currentPage += 1
        isFetchingPage = true
        
        BookStoreAPI(searchKeyword: keyword, pageIndex: currentPage).request { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.isFetchingPage = false
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
}
