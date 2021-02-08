//
//  APIRouter.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation

public enum APIServiceError: Error {
    case decodeError
    case invalidResponse
    case invalidEndpoint
    case noData
    case apiError
    
    var description: String {
        switch self {
        case .decodeError: return "Decoding error"
        case .invalidResponse: return "Invalid response"
        case .invalidEndpoint: return "Invalid parameters or request URL"
        case .noData: return "No data returned from the API call"
        case .apiError: return "API failed. Unable to fetch data"
        }
    }
    
}

protocol APIRouter {
    
    @discardableResult
    func performRequest<T: Decodable>(of: T.Type, with route: APIConfiguration, ulr: String?, completion: @escaping (Result<T, APIServiceError>) -> Void) -> URLSessionTask?
}

extension APIRouter {
    
    func getURL(_ route: APIConfiguration) -> URL? {
        let path = route.path
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = route.parameters
        return urlComponents?.url
    }
    
    @discardableResult
    func performRequest<T: Decodable>(of: T.Type, with route: APIConfiguration, url: String?, completion: @escaping (Result<T, APIServiceError>) -> Void) -> URLSessionDataTask? {
        var finalURL: URL
        
        if let input = url, let inputURL = URL(string: input) {
            finalURL = inputURL
        } else {
            guard let routeURL = getURL(route) else {
                completion(.failure(.invalidEndpoint))
                return nil
            }
            finalURL = routeURL
        }
        
        let task = URLSession.shared.dataTask(with: finalURL) { result in
            
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)? .statusCode, 200..<299 ~= statusCode else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }
                
                do{
                    let values = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(values))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodeError))
                    }
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    completion(.failure(.apiError))
                }
            }
            
        }
        task.resume()
        return task
    }

}
