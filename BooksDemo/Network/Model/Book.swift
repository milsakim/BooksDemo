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

struct BookDetailResponse: Codable {
    var title: String
    var subtitle: String
    var authors: String
    var publisher: String
    var language: String
    var isbn10: String
    var isbn13: String
    var pages: String
    var year: String
    var rating: String
    var desc: String
    var price: String
    var image: String
    var url: String
}
