//
//  BookDetailViewModel.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/09/01.
//

import Foundation
import Combine

class BookDetailViewModel: ObservableObject {
    @Published var bookDetail: BookDetailResponse?
    @Published var isFetchingPage: Bool = false
    
    var isbn: String
    
    // MARK: - Initializer
    
    init(isbn: String) {
        print("--- BookDetailViewModel init ---")
        self.isbn = isbn
    }
    
    // MARK: - Deinitializer
    
    deinit {
        print("--- BookDetailViewModel deinit ---")
    }
    
    // MARK: -
    
    func fetchBookDetailInformation() {
        print("--- \(#function) ---")
        BookDetailAPI(isbn: isbn).request { result in
            switch result {
            case .success(let response):
                print("--- response: \(response) ---")
                DispatchQueue.main.async {
                    self.bookDetail = response
                }
            case .failure(let error):
                print("--- error: \(error) ---")
            }
        }
    }
}
