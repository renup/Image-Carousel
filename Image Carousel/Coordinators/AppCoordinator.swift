//
//  AppCoordinator.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    func stop()
//    var presenterViewController: UIViewController { get }
//    var navigationViewController: UINavigationController { get }
}

final class AppCoordinator: Coordinator {
        
    let window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let imagesViewController = ImagesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
       let navigationViewController = UINavigationController(rootViewController: imagesViewController)
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
    }
    
    func stop() { }

    
}
