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
    
    init(_ navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    func start() {
        imagesCollectionViewController = ImagesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        imagesCollectionViewController?.didSelectAlbum = {[weak self] albums in
            guard let self = self else { return }
            self.albumCarouselViewController = AlbumCarouselViewController()
            self.albumCarouselViewController?.photosList = albums
            self.albumCarouselViewController?.viewModel = self.imagesCollectionViewController?.viewModel
            self.navigationViewController.pushViewController(self.albumCarouselViewController!, animated: true)
        }
        navigationViewController.pushViewController(imagesCollectionViewController!, animated: true)
    }
    
    func stop() {
        
    }
    
}


