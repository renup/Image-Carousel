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
    let serialQueue = DispatchQueue(label: "com.cocoa.imageDictionaryQueue")
    var imageNameDictionary = [String : String]()

    func getManifests(_ completion: @escaping (Result<ManifestResponse, APIServiceError>) -> Void) {
        networkService.performRequest(route: ManifestEndpoint.manifest, completion: completion)
    }
    
    @discardableResult
    func getImageDetailsAndImage(_ identifier: String, _ completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        let group = DispatchGroup()
        var resultImage: UIImage?
        var task: URLSessionDataTask?
        
        group.enter()
        fetchImageDetails(identifier: identifier) {[weak self] (result) in
            switch result {
            case .success(let imageResponse):
                self?.serialQueue.sync {
                    self?.imageNameDictionary[identifier] = imageResponse.name
                }
                group.enter()
               task = self?.fetchImage(imageURL: imageResponse.url) { (result) in
                    resultImage = result
                    group.leave()
               }
                group.leave()
            case .failure(let error):
                print("error while getting image details = \(error)")
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
    
    func fetchImage(imageURL: String, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        if  let image = imageCache.object(forKey: imageURL as NSString) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            //download it
           return networkService.performRequestForImage(route: ManifestEndpoint.image(imageURL: imageURL)) { (result) in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else { return }
                    let url = imageURL as NSString
                    DispatchQueue.main.async {
                        self.serialQueue.sync {
                            self.imageCache.setObject(image, forKey: url)
                        }
                        completion(image)
                    }
                case .failure(let error):
                    print("error while downloading the image = \(error)")
                }
            }
        } //end of else
        return nil
    }
    
    func shouldShowError(error: APIServiceError) -> Bool {
        guard error == .apiError else {  print(error.description); return false }
        return true
    }
}
