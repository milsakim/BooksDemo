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
    
    func fetchDetailInformation() {
        Task {
            do {
                let response: BookDetailResponse = try await BookDetailAPI(isbn: isbn).request()
                
                DispatchQueue.main.async { [weak self] in
                    self?.bookDetail = response
                }
            }
            catch {
                print("--- error ---")
            }
        }
    }
}
