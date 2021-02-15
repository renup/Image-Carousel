//
//  ManifestEndpoint.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation

enum ManifestEndpoint: APIConfiguration {
    case manifest
    case imageDetail(identifier: String)
    case image(imageURL: String)
    
    private struct EndpointConstants {
        static let manifest = "manifest"
        static let imageDetail = "image/"
    }
    
    var method: String {
        switch self {
        case .manifest, .imageDetail, .image: return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .manifest, .imageDetail, .image:
            return []
        }
    }
    
    var path: String {
        switch self {
        case .manifest:
            return Constants.baseURLString + EndpointConstants.manifest
        case .imageDetail(identifier: let identifier):
            return Constants.baseURLString + EndpointConstants.imageDetail + identifier
        case .image(let imageURL):
            return imageURL
        }
    }
    
    
}
