//
//  APIConfiguration.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation

protocol APIConfiguration {
    var method: String { get }
    var parameters: [URLQueryItem] { get }
    var path: String { get }
}
