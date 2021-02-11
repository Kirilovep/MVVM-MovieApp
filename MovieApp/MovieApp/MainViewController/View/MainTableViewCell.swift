//
//  MainTableViewCell.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    //MARK: - IBOutlets -
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    
    
    func hideView(_ isHidden: Bool) {
        posterImage.isHidden = isHidden
        titleLabel.isHidden = isHidden
        voteAverageLabel.isHidden = isHidden
        overviewLabel.isHidden = isHidden
        releaseDataLabel.isHidden = isHidden
    }
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            
            guard let viewModel = viewModel else { return }
            
            if viewModel.voteAverage >= 5.0 {
                self.voteAverageLabel.textColor = .green
            } else {
                self.voteAverageLabel.textColor = .orange
            }
            
            titleLabel.text = viewModel.title
            voteAverageLabel.text = String(viewModel.voteAverage)
            overviewLabel.text = viewModel.overview
            releaseDataLabel.text = viewModel.releaseDate
            
            let url = URL(string: Urls.baseImageUrl.rawValue + viewModel.posterPath)
            self.posterImage.kf.indicatorType = .activity
            self.posterImage.kf.setImage(with: url)
            
            
            
            
        }
    }
    
    
    
    
    
    //MARK: - Functions -
    func configure(_ result: ResultsOfMovies) {
        self.titleLabel.text = result.title
        if result.voteAverage ?? 0 >= 5.0 {
            self.voteAverageLabel.textColor = .green
        } else {
            self.voteAverageLabel.textColor = .orange
        }
        self.voteAverageLabel.text = String(result.voteAverage ?? 0)
        self.overviewLabel.text = result.overview
        self.releaseDataLabel.text = result.releaseDate
        if let posterPath = result.posterPath {
            let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
            self.posterImage.kf.indicatorType = .activity
            self.posterImage.kf.setImage(with: url)
        } else {
            self.posterImage.image = UIImage(named: Images.noPoster.rawValue)
        }
        
    }
    func configureFromCoreData(_ result: MovieCoreData) {
        self.titleLabel.text = result.title
        if result.voteAverage >= 5.0 {
            self.voteAverageLabel.textColor = .green
        } else if result.voteAverage == 0.0{
            self.voteAverageLabel.isHidden = true
        } else {
            self.voteAverageLabel.textColor = .orange
        }
        self.voteAverageLabel.text = String(result.voteAverage)
        if let releaseDate = result.releaseDate {
            self.releaseDataLabel.text = releaseDate
        } else {
            self.releaseDataLabel.text = result.department
        }
        self.overviewLabel.text = result.overview
        if let posterPath = result.image {
            let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
            self.posterImage.kf.indicatorType = .activity
            self.posterImage.kf.setImage(with: url)
        }else {
            self.posterImage.image = UIImage(named: Images.noPoster.rawValue)
        }
    }
    func configurePeople(_ results: ResultsSearch) {
        self.titleLabel.text = results.name
        self.overviewLabel.isHidden = true
        self.voteAverageLabel.isHidden = true
        self.releaseDataLabel.text = results.knownForDepartment
        if let posterPath = results.profilePath {
            let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
            self.posterImage.kf.indicatorType = .activity
            self.posterImage.kf.setImage(with: url)
        } else {
            self.posterImage.image = UIImage(named: Images.noPoster.rawValue)
        }
    }
}
