//
//  PaginatedAlbumImagesViewController.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/15/21.
//

import Foundation
import UIKit

final class AlbumCarouselViewController: UIViewController {
    
    struct Constants {
        static let carouselWidth: CGFloat = (UIScreen.main.bounds.width - UIScreen.main.bounds.width/4)
    }
    var viewModel: ImagesCollectionViewModel?
    
    var photosList = [String]()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isPagingEnabled = true
        //TODO: set the content size
        scroll.delegate = self
        return scroll
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
//        pageControl.numberOfPages = photosList.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
        pageControl.backgroundColor = .green
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    override func loadView() {
        super.loadView()
        setUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = .red
        view.backgroundColor = .cyan
    }
    
    private func setUp() {
        let photoView = PhotoView(frame: CGRect(x:0, y: 0, width: Constants.carouselWidth, height: Constants.carouselWidth))
        photoView.fetchImage(viewModel: viewModel!, identifier: photosList[0])
        photoView.backgroundColor = .yellow

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        scrollView.contentSize = CGSize(width: Constants.carouselWidth * CGFloat(photosList.count), height: Constants.carouselWidth)
        
        scrollView.widthAnchor.constraint(equalToConstant: Constants.carouselWidth).isActive = true
//        scrollView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 9.0/16.0).isActive = true

        scrollView.widthAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 16.0/9.0).isActive = true
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        scrollView.addSubview(photoView)
        
        view.wrap(view: pageControl, exceptTop: true, exceptBottom: true)
        
        pageControl.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        
        
        pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor , constant: 20.0).isActive = true
    }
    
    @objc
    func pageControlTapHandler(sender: UIPageControl) {
        scrollView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
    
}

extension AlbumCarouselViewController: UIScrollViewDelegate {
    
}
