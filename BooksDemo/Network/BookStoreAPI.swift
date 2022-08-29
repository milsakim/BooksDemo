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
