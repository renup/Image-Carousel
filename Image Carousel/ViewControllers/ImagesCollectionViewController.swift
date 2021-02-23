//
//  ImagesCollectionViewController.swift
//  Image Carousel
//
//  Created by Renu Punjabi on 2/22/21.
//

import Foundation
import UIKit

final class ImagesCollectionViewController: UICollectionViewController {
    var photosList = [String]()
    var viewModel: ImagesCollectionViewModel?
    
    struct Constants {
        static let cellIdentifier = "PhotoCell"
        static let sectionInsets = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        static let itemsPerRow: CGFloat = 2
        static let spacing: CGFloat = 8.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
                
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
}

extension ImagesCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! PhotoCell
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        cell.configure(viewModel: viewModel, identifier: photosList[indexPath.row])
        return cell
    }
}

extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
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
