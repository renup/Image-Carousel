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

final class NetworkService {
    
    private func getURL(_ route: APIConfiguration) -> URL? {
        let path = route.path
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = route.parameters
        return urlComponents?.url
    }
    
    private func createRequest(route: APIConfiguration) -> URLRequest? {
        guard let url = getURL(route) else { return nil }
        let method = route.method
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(Constants.apiValue, forHTTPHeaderField: Constants.apiKey)
        return request
    }
    
    @discardableResult
    func performRequestForImage(route: APIConfiguration, completion: @escaping (Result<Data, APIServiceError>) -> Void) -> URLSessionDataTask? {
        guard let request = createRequest(route: route) else {
            completion(.failure(.invalidEndpoint))
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: request) { result in
            
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }
                completion(.success(data)) // avoid converting to image from data in main thread
            case .failure:
                DispatchQueue.main.async {
                    completion(.failure(.apiError))
                }
            }
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping (Result<T, APIServiceError>) -> Void) -> URLSessionDataTask? {
        
        guard let request = createRequest(route: route) else {
            completion(.failure(.invalidEndpoint))
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: request) { result in
            
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)? .statusCode, 200..<299 ~= statusCode else {
                   // DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                   // }
                    return
                }
                
                do{
                    let values = try JSONDecoder().decode(T.self, from: data)
                  //  DispatchQueue.main.async {
                        completion(.success(values))
                  //  }
                } catch {
                    //DispatchQueue.main.async {
                        completion(.failure(.decodeError))
                   // }
                }
                
            case .failure(_):
               // DispatchQueue.main.async {
                    completion(.failure(.apiError))
               // }
            }
        }
        task.resume()
        return task
    }

}
