//
//  ImagesCollectionViewController.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation
import UIKit

final class ImagesCollectionViewController: UICollectionViewController {
    
    private let sectionInsets = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    
    private let itemsPerRow: CGFloat = 2
    
    private let viewModel = ImagesCollectionViewModel()
    
    private var manifests: [[String]] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
                
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: "AlbumCell")
        
        viewModel.getManifests { (result) in
            switch result {
            case .success(let response):
                print(response.manifest)
                DispatchQueue.main.async {
                    self.manifests = response.manifest
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manifests.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        let itemArray = manifests[indexPath.row]
        cell.configure(viewModel: viewModel, identifier: itemArray[indexPath.row])
        print("identifier = \(itemArray[indexPath.row])")
        cell.backgroundColor = .white
        return cell
    }
}


extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
      }
      
      func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
      ) -> UIEdgeInsets {
        return sectionInsets
      }
      
      func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
        return sectionInsets.left
      }

}
