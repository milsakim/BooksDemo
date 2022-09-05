//
//  NetworkRequestable.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/27.
//

import Foundation

enum NetworkRequestError: Error {
    case urlRequestError
    case httpError
    case dataError
    case decodingError
}

enum HTTPMethod {
    case get
}

/// baseURL(String 타입)과 path(String 타입)의 interpolation으로 URL을 생성하고 있음.
/// 향후 encoding이 필요해질 경우 URLComponent로 변경할 예정임.
protocol NetworkRequestable {
    associatedtype Response: Codable
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    
    func parse(data: Data) throws -> Response
}

extension NetworkRequestable {
    func createURL() -> URL? {
        return URL(string: baseURL + path)
    }
    
    func createURLRequest() -> URLRequest? {
        guard let url: URL = createURL() else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    func request(completionHandler: @escaping (Result<Response, Error>) -> Void) {
        guard let request: URLRequest = createURLRequest() else {
            completionHandler(.failure(NetworkRequestError.urlRequestError))
            return
        }
        
        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("--- http error ---")
                completionHandler(.failure(NetworkRequestError.httpError))
                return
            }
            
            guard let data = data else {
                print("--- no data: \(error ?? NetworkRequestError.dataError) ---")
                completionHandler(.failure(NetworkRequestError.dataError))
                return
            }
            
            guard let decodedResponse: Response = try? parse(data: data) else {
                print("--- failed to decode ---")
                completionHandler(.failure(NetworkRequestError.decodingError))
                return
            }
            
            print("--- success ---")
            completionHandler(.success(decodedResponse))
        }
        
        dataTask.resume()
    }
    
}
