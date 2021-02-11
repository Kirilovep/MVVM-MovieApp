//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by shizo on 06.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
class MoviesTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    weak var viewModel: MoviesTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.titleLabel.text = viewModel.title
            if let voteAverage = viewModel.voteAverage {
                self.voteAverageLabel.text = "\(String(describing: voteAverage))"
            }
            
            if let averageVote = viewModel.voteAverage {
                if averageVote >= 5.0 {
                    self.voteAverageLabel.textColor = .green
                } else if averageVote <= 4.9  {
                    self.voteAverageLabel.textColor = .systemOrange
                } else if averageVote <= 3.0 {
                    self.voteAverageLabel.textColor = .red
                } else if averageVote == 0.0 {
                    self.voteAverageLabel.textColor = .red
                }
                if let characterName = viewModel.character {
                    self.characterLabel.text = "as \(characterName)"
                } else if let job = viewModel.job {
                    self.characterLabel.text = "Job: \(job)"
                }
                if let posterPath = viewModel.posterPath {
                    let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
                    self.movieImage.kf.indicatorType = .activity
                    self.movieImage.kf.setImage(with: url)
                } else {
                    self.movieImage.image = UIImage(named: Images.noPoster.rawValue)
                }
                if let releaseData = viewModel.releaseDate {
                    self.yearLabel.text = releaseData
                }
            }
        }
    }
    
}
