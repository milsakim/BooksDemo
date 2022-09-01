//
//  BookStoreAPI.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/28.
//

import Foundation

class BookStoreRequestable: NetworkRequestable {
    typealias Response = SearchResponse
    
    var baseURL: String = "https://api.itbook.store/1.0/search/"
    var path: String { "\(searchKeyword)/\(pageIndex)" }
    var httpMethod: HTTPMethod = .get
    
    var searchKeyword: String
    var pageIndex: Int = 1
    
    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
    }
}

struct BookDetailAPI: NetworkRequestable {
    typealias Response = BookDetailResponse
    
    var baseURL: String = "https://api.itbook.store/1.0/books/"
    var path: String { "\(isbn)" }
    var httpMethod: HTTPMethod = .get
    
    var isbn: String
    
    init(isbn: String) {
        self.isbn = isbn
    }
}
