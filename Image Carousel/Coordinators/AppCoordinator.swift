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
}

final class AppCoordinator: Coordinator {
        
    let window: UIWindow
    var imagesCollectionCoordinator: ImagesCollectionCoordinator?
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
       let navigationViewController = UINavigationController()
        imagesCollectionCoordinator = ImagesCollectionCoordinator(navigationViewController)
        imagesCollectionCoordinator?.start()
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
    }
    
    func stop() { }

    
}
