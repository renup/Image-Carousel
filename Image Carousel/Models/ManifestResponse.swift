//
//  ManifestResponse.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation

public struct ManifestResponse: Decodable {
    let manifest: [[String]]
    
    enum CodingKeys: String, CodingKey {
        case manifest = "manifest"
    }
}
