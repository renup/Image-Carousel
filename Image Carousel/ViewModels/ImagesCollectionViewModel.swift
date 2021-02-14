//
//  ImagesCollectionViewModel.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation

final class ImagesCollectionViewModel {
    
    func getManifests(_ completion: @escaping (Result<ManifestResponse, APIServiceError>) -> Void) {
        NetworkService().performRequest(route: ManifestEndpoint.manifest, completion: completion)
    }
}
