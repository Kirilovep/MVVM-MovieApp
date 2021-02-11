//
//  ImageCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 06.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
class ImageCollectionViewCell: UICollectionViewCell {
    //MARK:- Properties -
    static let size = CGSize(width: 51, height: 77)
    
    //MARK: - IBOutlets -
    @IBOutlet weak var personImage: UIImageView!
    
    
    weak var viewModel: CollectionViewImagesViewModel? {
        willSet(viewModel) {
            
            guard let viewModel = viewModel else { return }
            
            let url = URL(string: Urls.baseImageUrl.rawValue + viewModel.imagePath)
            personImage.kf.indicatorType = .activity
            personImage.kf.setImage(with: url)
        
            
        }
    }
    //MARK: - LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        
        personImage.layer.cornerRadius = 4
        personImage.clipsToBounds = true
    }
    
}

