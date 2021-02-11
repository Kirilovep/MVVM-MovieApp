//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import YoutubeDirectLinkExtractor
class DetailMovieViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    //MARK:- Properties -
    
    var viewModel: DetailViewModelType?

    private var timer = Timer()
    private let extractor = LinkExtractor()
 
    //MARK:- IBOutlets-
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var videosLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var castCollectionView: UICollectionView! {
        didSet {
            castCollectionView.delegate = self
            castCollectionView.dataSource = self
            let nib = UINib(nibName: Cells.castCollectionCellNib.rawValue, bundle: nil)
            castCollectionView.register(nib, forCellWithReuseIdentifier: Cells.castCollectionCellIdentefier.rawValue)
            
        }
    }
    @IBOutlet weak var crewCollectionView: UICollectionView! {
        didSet {
            crewCollectionView.delegate = self
            crewCollectionView.dataSource = self
            let crewNib = UINib(nibName: Cells.crewCollectionCellNib.rawValue, bundle: nil)
            crewCollectionView.register(crewNib, forCellWithReuseIdentifier: Cells.crewCollectionCellIdentifier.rawValue)
        }
    }
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.delegate = self
            videoCollectionView.dataSource = self
            let videoNib = UINib(nibName: Cells.videoColectionCellNib.rawValue, bundle: nil)
            videoCollectionView.register(videoNib, forCellWithReuseIdentifier: Cells.videoCollectionCellIdentifier.rawValue)
            
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                self.addButton()
            })
        }
    }
    
    //MARK:- LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        hideMoviesInformation(true)
        requestDetails()
        requestCasts()
        requestCrews()
        requestVideos()
    }
    
    //MARK:- Private func-
    private func requestCasts() {
        viewModel?.fetchCast(viewModel?.id ?? 0, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.castCollectionView.reloadData()
            }
        })
    }
        
    private func requestCrews() {
        viewModel?.fetchCrew(viewModel?.id ?? 0, completion: { [ weak self] in
            DispatchQueue.main.async {
                self?.crewCollectionView.reloadData()
            }
        })
    }

    private func requestDetails() {
        viewModel?.fetchDetails(viewModel?.id ?? 0, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.hideMoviesInformation(false)
                self?.updateView()
            }
        })
    }
    

    private func requestVideos() {
        viewModel?.fetchVideos(viewModel?.id ?? 0, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.videoCollectionView.reloadData()
            }
        })
    }

    private func updateView() {
            self.activityIndicator.startAnimating()
            self.titleLabel.text = self.viewModel?.title
            if let voteAverage = self.viewModel?.voteAverage {
                self.voteAverageLabel.text = "\(voteAverage)"
            }
            if self.viewModel?.voteAverage ?? 0 >= 5.0 {
                self.voteAverageLabel.textColor = .green
            } else {
                self.voteAverageLabel.textColor = .orange
            }
            self.dateLabel.text = self.viewModel?.releaseDate
            self.releasedLabel.text = self.viewModel?.releaseDate
            self.overviewLabel.text = self.viewModel?.overview
            self.languageLabel.text = self.viewModel?.originalLanguage
            if let posterPath = self.viewModel?.backdropPath {
                let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
                self.detailImageView.kf.indicatorType = .activity
                self.detailImageView.kf.setImage(with: url)
            } else {
                self.detailImageView.image = UIImage(named: Images.noPoster.rawValue)
            }
            if self.viewModel?.budget == 0 {
                self.budgetLabel.text = "Information is coming soon"
            } else {
                self.budgetLabel.text = "\(self.viewModel?.budget ?? 0)$"
            }
            guard let runTime = self.viewModel?.runtime  else { return }
            self.runTimeLabel.text = "\(runTime) minutes"
            self.activityIndicator.stopAnimating()
    }
    private func addButton() {
        let likeTappedButton = UIBarButtonItem(image: #imageLiteral(resourceName: "like"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = likeTappedButton
    }
    
    @objc
    private func addTapped() {
        guard let movieTitle = viewModel?.title else { return }
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let movieData = MovieCoreData(context: context)
        movieData.title = movieTitle
        movieData.image = viewModel?.posterPath
        movieData.releaseDate = viewModel?.releaseDate
        movieData.overview = viewModel?.overview
        let idMovie = Int64(viewModel?.id ?? 0)
        movieData.id = idMovie
        movieData.voteAverage = Double(viewModel?.voteAverage ?? 0.1)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "heart")
    }
    private func hideMoviesInformation(_ isHidden: Bool) {
        titleLabel.isHidden = isHidden
        voteAverageLabel.isHidden = isHidden
        dateLabel.isHidden = isHidden
        releasedLabel.isHidden = isHidden
        overviewLabel.isHidden = isHidden
        languageLabel.isHidden = isHidden
        budgetLabel.isHidden = isHidden
        runTimeLabel.isHidden = isHidden
        detailImageView.isHidden = isHidden
        videosLabel.isHidden = isHidden
        crewLabel.isHidden = isHidden
        castLabel.isHidden = isHidden
    }
}
//MARK:- Collection View extension -
extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView {
            return viewModel?.numberOfItemsForCast() ?? 0
        } else if collectionView == crewCollectionView{
            return viewModel?.numberOfItemsForCrew() ?? 0
        } else if collectionView == videoCollectionView{
            return viewModel?.numbersOfItemsForVideos() ?? 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == castCollectionView {
            let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.castCollectionCellIdentefier.rawValue, for: indexPath) as? CastCollectionViewCell
            
            guard let collectionViewCell = castCell else { return UICollectionViewCell() }
            
            let cellViewModel = viewModel?.castCellViewModel(indexPath)
            collectionViewCell.viewModel = cellViewModel
            
            return collectionViewCell
            
        } else if collectionView == crewCollectionView {
            let crewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.crewCollectionCellIdentifier.rawValue, for: indexPath) as? CrewCollectionViewCell
        
            guard let collectionViewCell = crewCell else { return UICollectionViewCell() }
            
            let cellViewModel = viewModel?.crewCellViewModel(indexPath)
            collectionViewCell.viewModel = cellViewModel

            return collectionViewCell
            
        } else if collectionView == videoCollectionView{
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.videoCollectionCellIdentifier.rawValue, for: indexPath) as? VideoCollectionViewCell
            
            guard let collectionViewCell = videoCell else { return UICollectionViewCell()}
            
            let cellViewModel = viewModel?.videosCellViewModel(indexPath)
            collectionViewCell.viewModel = cellViewModel
            

            return collectionViewCell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == videoCollectionView {
            extractor.getUrlFromKey(key: viewModel?.videos[indexPath.row].key) { [weak self] (url) in
                guard let self = self else { return }
                let player = AVPlayer(url: url)
                let avPlayerViewController = AVPlayerViewController()
                avPlayerViewController.player = player
                self.present(avPlayerViewController, animated: true) {
                    avPlayerViewController.player?.play()
                }
            }
        } else if collectionView == castCollectionView {
            let desVC = storyboard?.instantiateViewController(identifier: ViewControllers.PeopleVCIdentifier.rawValue) as! PeopleViewController
            
            guard let viewModel = viewModel else { return }
            viewModel.selectRow(atIndexPath: indexPath)
            
            desVC.castViewModel = viewModel.viewModelForCastSelectedRow()

            navigationController?.pushViewController(desVC, animated: true)
        } else if collectionView == crewCollectionView {
            let desVC = storyboard?.instantiateViewController(identifier: ViewControllers.PeopleVCIdentifier.rawValue) as! PeopleViewController
            
            guard let viewModel = viewModel else { return }
            viewModel.selectRow(atIndexPath: indexPath)
            
            desVC.crewViewModel = viewModel.viewModelForCrewSelectedRow()
            
            navigationController?.pushViewController(desVC, animated: true)
        }
    }
}
