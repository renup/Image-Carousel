//
//  PhotoView.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/15/21.
//

import Foundation
import UIKit

final class PhotoView: UIView {
    
    struct Constants {
        static let margin = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
//        view.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        return view
    }()
    
    private lazy var photoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [photoImageView, photoLabel])
        stack.axis = .vertical
        stack.spacing = 5.0
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.wrap(view: stack, insets: Constants.margin)
        stack.heightAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 9.0/16.0).isActive = true
    }
    
}
