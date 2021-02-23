//
//  AlbumCollectionViewController.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/7/21.
//

import Foundation
import UIKit

final class AlbumCollectionViewController: UICollectionViewController {
    
    struct Constants {
        static let cellIdentifier = "AlbumCell"
        static let sectionInsets = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        static let itemsPerRow: CGFloat = 2
    }
      
    weak var coordinator: ImagesCollectionCoordinator?
    
    let viewModel = ImagesCollectionViewModel()
        
    private var manifests: [[String]] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectAlbum: ([String]) -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
                
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        
        viewModel.getManifests {[weak self] (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.manifests = response.manifest
                }
            case .failure(let error):
                if ((self?.viewModel.shouldShowError(error: error)) != nil) {
                    self?.showAPIError(error)
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manifests.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! AlbumCell
        let itemArray = manifests[indexPath.row]
        cell.configure(viewModel: viewModel, identifier: itemArray[0])
        cell.backgroundColor = .white
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let selectedAlbum = manifests[indexPath.row]
        didSelectAlbum(selectedAlbum)
       }
}


extension AlbumCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
        let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / Constants.itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
      }
      
      func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
      ) -> UIEdgeInsets {
        return Constants.sectionInsets
      }
      
      func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
        return Constants.sectionInsets.left
      }
}
