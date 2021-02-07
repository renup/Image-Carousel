//
//  ImagesCollectionView.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation
import UIKit

final class ImagesCollectionView: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 200, height: 200)
        super.init(frame: .zero, collectionViewLayout: layout)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        backgroundColor = .white
    }
    
    
}
