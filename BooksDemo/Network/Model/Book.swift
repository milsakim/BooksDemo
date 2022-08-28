//
//  Book.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/24.
//

import Foundation

struct SearchResponse: Codable {
    var total: String
    var page: String
    var books: [Book]
}

struct Book: Codable {
    var title: String
    var subtitle: String
    var isbn13: String
    var price: String
    var image: String
    var url: String
}
