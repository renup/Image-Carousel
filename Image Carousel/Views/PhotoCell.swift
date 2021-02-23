//
//  PhotoCell.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/22/21.
//

import Foundation
import UIKit

final class PhotoCell: UICollectionViewCell {
     
    var task: URLSessionDataTask?
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    private lazy var imageName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, imageName])
        stack.axis = .vertical
        stack.spacing = 8.0
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        wrap(view: stackView)
        backgroundColor = .white
        contentView.autoresizingMask = [.flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ImagesCollectionViewModel, identifier: String) {
        imageView.image = UIImage(named: "placeholder_album")
        task = viewModel.getImageDetailsAndImage(identifier, { (image) in
            self.imageName.text = viewModel.imageNameDictionary[identifier]
            self.imageView.image = image
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        imageView.image = nil
    }
}
