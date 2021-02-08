//
//  URLSession+Utilities.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation

extension URLSession {
    
    func dataTask(with url: URL, completion: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        
        return dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response, let data = data else {
                let err = NSError(domain: "error", code: 0, userInfo: nil)
                completion(.failure(err))
                return
            }
            completion(.success((response, data)))
        }
    }
    
}
