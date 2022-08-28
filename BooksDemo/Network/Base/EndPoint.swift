//
//  EndPoint.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/27.
//

import Foundation

protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var parameter: [URLQueryItem] { get }
    var headers: [Header] { get }
    var method: HTTPMethod { get }
    
    func getUrl() -> URL?
}

extension EndPoint {
    func getUrl() -> URL? {
        var component: URLComponents = .init()
        component.scheme = "https"
        component.host = baseURL
        component.path = path
        component.queryItems = parameter
        
        return component.url
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "Delete"
}

struct Header {
    var key: String
    var value: String
}
