//
//  CrewCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 03.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {
    //MARK:- IBOutlets -
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    
    weak var viewModel: CollectionViewCrewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.nameLabel.text = viewModel.name
            self.jobLabel.text = viewModel.job
            if let profilePath = viewModel.profilePath {
                let url = URL(string: Urls.baseImageUrl.rawValue + profilePath )
                self.characterImage.kf.indicatorType = .activity
                self.characterImage.kf.setImage(with: url)
            } else {
                self.characterImage.image = UIImage(named: Images.imageForPeople.rawValue)
            }
        }
    }
}




