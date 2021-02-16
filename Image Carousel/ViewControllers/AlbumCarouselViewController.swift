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
        static let carouselWidth: CGFloat = 250.0
    }
    
    var photosList = [String]()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x:0, y: 0, width: 250, height: 250))
        scroll.showsHorizontalScrollIndicator = false
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
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        let photoView = PhotoView(frame: CGRect(x:0, y: 0, width: Constants.carouselWidth, height: Constants.carouselWidth))

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        scrollView.contentSize = CGSize(width: Constants.carouselWidth * CGFloat(photosList.count), height: Constants.carouselWidth)
        
        scrollView.addSubview(photoView)
        
    }
    
    @objc
    func pageControlTapHandler(sender: UIPageControl) {
        scrollView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
    
}

extension AlbumCarouselViewController: UIScrollViewDelegate {
    
}
