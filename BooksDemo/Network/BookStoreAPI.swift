//
//  BookStoreAPI.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/28.
//

import Foundation

struct BookStoreAPI: NetworkRequestable {
    typealias Response = SearchResponse
    
    var baseURL: String = "https://api.itbook.store/1.0/search/"
    var path: String { "\(searchKeyword)/\(pageIndex)" }
    var httpMethod: HTTPMethod = .get
    
    var searchKeyword: String
    var pageIndex: Int
    
    func parse(data: Data) throws -> SearchResponse {
        print("--- parse ---")
        return try JSONDecoder().decode(SearchResponse.self, from: data)
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
    
    func parse(data: Data) throws -> BookDetailResponse {
        return try JSONDecoder().decode(BookDetailResponse.self, from: data)
    }
}
