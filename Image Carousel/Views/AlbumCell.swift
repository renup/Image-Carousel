//
//  AlbumCell.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/14/21.
//

import Foundation
import UIKit

final class AlbumCell: UICollectionViewCell {
     
    var task: URLSessionDataTask?
    
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        wrap(view: imageView)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ImagesCollectionViewModel, identifier: String) {
        imageView.image = UIImage(named: "placeholder_album")
        task = viewModel.getImageDetailsAndImage(identifier, { (image) in
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
