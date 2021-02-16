//
//  ImagesCollectionCoordinator.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/15/21.
//

import Foundation
import UIKit

final class ImagesCollectionCoordinator: Coordinator {
    
    var navigationViewController: UINavigationController
    var imagesCollectionViewController: ImagesCollectionViewController?
    var albumCarouselViewController: AlbumCarouselViewController?
    var viewModel = ImagesCollectionViewModel()
    
    init(_ navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    func start() {
        guard let collectionViewController = navigationViewController.viewControllers.first as? ImagesCollectionViewController else { return }
        imagesCollectionViewController = collectionViewController
        imagesCollectionViewController?.didSelectAlbum = {[weak self] albums in
            guard let self = self else { return }
            self.albumCarouselViewController = AlbumCarouselViewController()
            self.albumCarouselViewController?.photosList = albums
            self.navigationViewController.pushViewController(self.albumCarouselViewController!, animated: true)
        }
    }
    
    func stop() {
        
    }
    
}

