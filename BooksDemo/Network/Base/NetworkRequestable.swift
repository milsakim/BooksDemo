//
//  NetworkRequestable.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/27.
//

import Foundation

protocol NetworkRequestable {
    associatedtype Response: Codable
    
    var requestTimeOut: Float { get }
    
    func request(_ request: RequestModel, completionHandler: @escaping (Result<Response, Error>) -> Void)
}


