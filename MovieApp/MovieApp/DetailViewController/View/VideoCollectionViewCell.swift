//
//  VideoCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
class VideoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var trailerName: UILabel!
    
    
    weak var viewModel: CollectionViewVideoCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.trailerName.text = viewModel.name
            if let key = viewModel.key {
                let url = URL(string: VideoUrls.baseurl.rawValue + key + VideoUrls.lasturl.rawValue )
                self.videoImage.kf.indicatorType = .activity
                self.videoImage.kf.setImage(with: url)
            } else {
                self.videoImage.image = UIImage(named: Images.imageForPeople.rawValue)
            }
            
        }
    }
    
    
    //MARK: - LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        videoImage.layer.cornerRadius = 5
        videoImage.clipsToBounds = true
    }
    
    //MARK: - Functions -
    func configure(_ video: Video) {
            self.trailerName.text = video.name
            if let key = video.key {
                let url = URL(string: VideoUrls.baseurl.rawValue + key + VideoUrls.lasturl.rawValue )
                self.videoImage.kf.indicatorType = .activity
                self.videoImage.kf.setImage(with: url)
            } else {
                self.videoImage.image = UIImage(named: Images.imageForPeople.rawValue)
            }
    }
}
