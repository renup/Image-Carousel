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
    var imagesCollectionViewController: ImagesCollectionViewController?
    
    init(_ navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }
    
    func start() {
        albumCollectionViewController = AlbumCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        albumCollectionViewController?.coordinator = self
        albumCollectionViewController?.didSelectAlbum = {[weak self] album in
            guard let self = self else { return }
            self.imagesCollectionViewController = ImagesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
            self.imagesCollectionViewController?.viewModel = self.albumCollectionViewController?.viewModel
            self.imagesCollectionViewController?.photosList = album
            self.navigationViewController.pushViewController(self.imagesCollectionViewController!, animated: true)
        }
        navigationViewController.pushViewController(albumCollectionViewController!, animated: true)
    }
    
    func stop() {
        
    }
    
}


