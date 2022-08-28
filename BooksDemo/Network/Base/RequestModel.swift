//
//  RequestModel.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/27.
//

import Foundation

// MARK: - endpoint로부터 request를 만드는 struct

struct RequestModel {
    var endPoint: EndPoint
    var body: Data?
    var requestTimeOut: Float?
    
    init(endPoint: EndPoint, requestBody: Data? = nil, requestTimeOut: Float? = nil) {
        self.endPoint = endPoint
        self.body = requestBody
        self.requestTimeOut = requestTimeOut
    }
    
    func getUrlRequest() -> URLRequest? {
        guard let url: URL = endPoint.getUrl() else {
            print("--- URL not found ---")
            return nil
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        // Add headers
        for header in endPoint.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
}
