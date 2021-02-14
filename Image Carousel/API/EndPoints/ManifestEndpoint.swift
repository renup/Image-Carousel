//
//  ManifestEndpoint.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation

enum ManifestEndpoint: APIConfiguration {
    case manifest
    
    private struct EndpointConstants {
        static let manifest = "manifest"
    }
    
    var method: String {
        switch self {
        case .manifest: return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .manifest:
            return []
        }
    }
    
    var path: String {
        switch self {
        case .manifest:
            return Constants.baseURLString + EndpointConstants.manifest
        }
    }
    
    
}
