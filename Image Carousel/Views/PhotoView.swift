//
//  PhotoView.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/15/21.
//

import Foundation
import UIKit

final class PhotoView: UIView {
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.wrap(view: photoImageView)
    }
    
    func fetchImage(viewModel: ImagesCollectionViewModel, identifier: String) {
        photoImageView.image = UIImage(named: "placeholder_album")
        viewModel.getImageDetailsAndImage(identifier, { (image) in
            print("inside viewmodel")
            self.photoImageView.image = image
        })
    }
    
}
