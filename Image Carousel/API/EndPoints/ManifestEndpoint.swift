//
//  ManifestEndpoint.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation

enum ManifestEndpoint: APIConfiguration {
    case manifest
    case image(identifier: String)
    
    private struct EndpointConstants {
        static let manifest = "manifest"
        static let image = "image"
    }
    
    var method: String {
        switch self {
        case .manifest, .image: return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .manifest, .image:
            return []
        }
    }
    
    var path: String {
        switch self {
        case .manifest:
            return Constants.baseURLString + EndpointConstants.manifest
        case .image(identifier: let identifier):
            return Constants.baseURLString + EndpointConstants.image + identifier
        }
    }
    
    
}
