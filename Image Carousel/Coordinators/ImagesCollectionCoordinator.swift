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
    var albumCollectionViewController: AlbumCollectionViewController?
    
    
    init(_ navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    func start() {
        albumCollectionViewController = AlbumCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        albumCollectionViewController?.didSelectAlbum = {[weak self] albums in
            guard let self = self else { return }
//            self.albumCarouselViewController = AlbumCollectionViewController()
//            self.albumCarouselViewController?.photosList = albums
//            self.albumCarouselViewController?.viewModel = self.imagesCollectionViewController?.viewModel
//            self.navigationViewController.pushViewController(self.albumCarouselViewController!, animated: true)
        }
        navigationViewController.pushViewController(albumCollectionViewController!, animated: true)
    }
    
    func stop() {
        
    }
    
}


