//
//  ImagesCollectionViewModel.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation
import UIKit

final class ImagesCollectionViewModel {
    
    let imageCache = NSCache<NSString, UIImage>()
    let networkService = NetworkService()
    
//    private lazy var group: DispatchGroup = {
//        return DispatchGroup()
//    }()
    
    func getManifests(_ completion: @escaping (Result<ManifestResponse, APIServiceError>) -> Void) {
        networkService.performRequest(route: ManifestEndpoint.manifest, completion: completion)
    }
    
    func getImageDetailsAndImage(_ identifier: String, _ completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        let group = DispatchGroup()
        var resultImage: UIImage?
        var resultFailure: APIServiceError?
        var task: URLSessionDataTask?
        
        group.enter()
        fetchImageDetails(identifier: identifier) {[weak self] (result) in
//            defer { group.leave() }
            switch result {
            case .success(let imageResponse):
                group.enter()
               task = self?.fetchImage(imageURL: imageResponse.url) { (result) in
//                    defer { group.leave() }
                    switch result {
                    case .success(let image):
                        resultImage = image
                        group.leave()
                    case .failure(let error):
                        resultFailure = error
                    }
               }
                group.leave()
            case .failure(let error):
                resultFailure = error
            }
            group.notify(queue: .main) {
                completion(resultImage)
            }
        }
        return task
    }
    
    @discardableResult
    func fetchImageDetails(identifier: String, completion: @escaping (Result<ImageResponse, APIServiceError>) -> Void) -> URLSessionDataTask? {
        
        return networkService.performRequest(route: ManifestEndpoint.imageDetail(identifier: identifier), completion: completion)
    }
    
    func fetchImage(imageURL: String, completion: @escaping ( Result<UIImage?, APIServiceError>) -> Void) -> URLSessionDataTask? {
        if  let image = imageCache.object(forKey: imageURL as NSString) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
        } else {
            //download it
           return networkService.performRequestForImage(route: ManifestEndpoint.image(imageURL: imageURL)) { (result) in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        print("received image")
                        completion(.success(image))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } //end of else
        return nil
    }
}
