//
//  ImagesCollectionViewModel.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation

final class ImagesCollectionViewModel {
    
    private lazy var manifestRouter: ManifestRouter = {
        return ManifestRouter()
    }()
    
    func getManifests() {
        manifestRouter.fetchManifest { (result) in
            switch result {
            case .success(let response):
                print(response.manifest)
            case .failure(let error):
                print(error)
            }
        }
    }
}
