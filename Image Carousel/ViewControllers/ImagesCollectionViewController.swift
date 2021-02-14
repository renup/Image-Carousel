//
//  ImagesCollectionViewController.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation
import UIKit

final class ImagesCollectionViewController: UIViewController {
    
    private lazy var imagesView: ImagesCollectionView = {
        let view = ImagesCollectionView()
        return view
    }()
    
    let viewModel = ImagesCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wrap(view: imagesView)
        
        imagesView.dataSource = self
        imagesView.delegate = self
                
        imagesView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "albumCell")
        viewModel.getManifests()
    }
}

extension ImagesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
    
    
}

extension ImagesCollectionViewController: UICollectionViewDelegate {
    
}
