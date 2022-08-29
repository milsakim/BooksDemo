//
//  BookStoreAPI.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/28.
//

import Foundation

enum BookSearchAPIError: Error {
    case urlRequestError
    case httpError
    case unknownError
}

struct BookStoreSearchEndPoint: EndPoint {
    let baseURL: String = "api.itbook.store"
    
    var path: String
    
    var parameter: [URLQueryItem] = []
    
    var headers: [Header] = []
    
    var method: HTTPMethod = .get
    
    init(searchKeyword: String, page: Int) {
        self.path = "/1.0/search/" + searchKeyword + "/" + "\(page)"
    }
}

class BookStoreRequestable: NetworkRequestable {
    var requestTimeOut: Float = 30
    
    func request(_ request: RequestModel, completionHandler: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let bookStoreRequest: URLRequest = request.getUrlRequest() else {
            print("--- fail to get url request ---")
            completionHandler(.failure(BookSearchAPIError.urlRequestError))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: bookStoreRequest) { data, response, error in
            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("--- http error ---")
                completionHandler(.failure(BookSearchAPIError.httpError))
                return
            }
            
            guard let data = data else {
                print("--- no data: \(error) ---")
                completionHandler(.failure(BookSearchAPIError.unknownError))
                return
            }
            
            guard let decodedResponse: SearchResponse = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                print("--- failed to decode ---")
                completionHandler(.failure(BookSearchAPIError.unknownError))
                return
            }
            
            print("--- success ---")
            completionHandler(.success(decodedResponse))
        }
        
        dataTask.resume()
    }
    
    func request(_ request: RequestModel) async throws -> SearchResponse {
        guard let bookStoreRequest: URLRequest = request.getUrlRequest() else {
            throw BookSearchAPIError.urlRequestError
        }
        
        let (data, response) = try await URLSession.shared.data(for: bookStoreRequest)
        
        guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw BookSearchAPIError.httpError
        }
        
        let decodedData: SearchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
        
        return decodedData
    }
}
