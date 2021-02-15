//
//  ImageResponse.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/14/21.
//

import Foundation

struct ImageResponse: Decodable {
    let name: String
    let url: String
    let type: String
    let width: Int
    let height: Int
}
