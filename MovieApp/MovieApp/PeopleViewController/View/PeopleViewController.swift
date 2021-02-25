//
//  PeopleViewController.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
import ExpandableLabel

class PeopleViewController: UIViewController {
    
    //MARK:- Properties -
    
    var crewViewModel: CrewViewModelType? 
    var castViewModel: CastViewModelType? 
    
    //MARK:- IBOutlets-
    @IBOutlet weak var knowForLabel: UILabel!
    @IBOutlet weak var graphyLabel: UILabel!
    @IBOutlet weak var moviesLabel: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthdayLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView! {
        didSet {
            imagesCollectionView.delegate = self
            imagesCollectionView.dataSource = self
            
            let nib = UINib(nibName: Cells.imageCollectionNib.rawValue, bundle: nil)
            imagesCollectionView.register(nib, forCellWithReuseIdentifier: Cells.imageCollectionCellIdentifier.rawValue)
        }
    }
    @IBOutlet weak var knowsForLabel: UILabel!
    @IBOutlet weak var biographyLabel: ExpandableLabel!
    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            moviesTableView.delegate = self
            moviesTableView.dataSource = self
            
            let nib = UINib(nibName: Cells.moviesTableViewCellNib.rawValue, bundle: nil)
            moviesTableView.register(nib, forCellReuseIdentifier: Cells.moviesCellIdentifier.rawValue)
            moviesTableView.rowHeight = 100
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        hidePersonInformation(true)
        addButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestInfo()
    }
    
    
    //MARK:- Private methods -
    private func setImagesForCastAndCrew() {
        if let profilePathCast = self.castViewModel?.personInfo?.profilePath {
            let url = URL(string: Urls.baseImageUrl.rawValue + profilePathCast )
            self.characterImage.kf.setImage(with: url)
        } else if let profilePathCrew = self.crewViewModel?.personInfo?.profilePath {
            let url = URL(string: Urls.baseImageUrl.rawValue + profilePathCrew)
            self.characterImage.kf.setImage(with: url)
        } else {
            self.characterImage.image = UIImage(named: Images.imageForPeople.rawValue)
        }
    }
    
    private func requestInfo() {
        if castViewModel == nil {
            crewViewModel?.fetchPersonInfo(crewViewModel?.detailCrew?.id ?? 0, completion: { [weak self] in
                DispatchQueue.main.async {
                    self?.updateView()
                }
            })
            crewViewModel?.fetchImages(crewViewModel?.detailCrew?.id ?? 0, completion: { [ weak self] in
                DispatchQueue.main.async {
                    self?.imagesCollectionView.reloadData()
                }
            })
            crewViewModel?.fetchMovies(crewViewModel?.detailCrew?.id ?? 0, completion: { [weak self] in
                DispatchQueue.main.async {
                    self?.tableViewHeight.constant = CGFloat(self?.crewViewModel?.tableViewHeigh() ?? 1)
                    self?.moviesTableView.reloadData()
                    
                }
            })
        } else {
            castViewModel?.fetchPersonInfo(castViewModel?.detailCast?.id ?? 0, completion: { [ weak self] in
                DispatchQueue.main.async {
                    self?.updateView()
                }
            })
            castViewModel?.fetchImages(castViewModel?.detailCast?.id ?? 0, completion: { [ weak self] in
                DispatchQueue.main.async {
                    self?.imagesCollectionView.reloadData()
                }
            })
            castViewModel?.fetchMovies(crewViewModel?.detailCrew?.id ?? 0, completion: { [weak self] in
                DispatchQueue.main.async {
                    self?.tableViewHeight.constant = CGFloat(self?.castViewModel?.tableViewHeigh() ?? 1)
                    self?.moviesTableView.reloadData()
                    
                }
            })
        }
    }
    
    
    private func updateView() {
        self.activityIndicator.startAnimating()
        self.hidePersonInformation(false)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let castName = castViewModel?.personInfo?.name {
            self.nameLabel.text = castName
            self.placeOfBirthdayLabel.text = self.castViewModel?.personInfo?.placeOfBirth
            self.knowsForLabel.text = self.castViewModel?.personInfo?.knownForDepartment
            if let birthday = self.castViewModel?.personInfo?.birthday,
               let date = dateFormatter.date(from: birthday){
                self.birthdayLabel.text = dateFormatter.string(from: date)
            } else {
                birthdayLabel.text = "Not available"
            }
            self.placeOfBirthdayLabel.text = self.castViewModel?.personInfo?.placeOfBirth
            self.knowForLabel.text = self.castViewModel?.personInfo?.knownForDepartment
        } else if let crewName = crewViewModel?.personInfo?.name {
            self.nameLabel.text = crewName
            self.placeOfBirthdayLabel.text = self.crewViewModel?.personInfo?.placeOfBirth
            self.knowsForLabel.text = self.crewViewModel?.personInfo?.knownForDepartment
            if let birthday = self.crewViewModel?.personInfo?.birthday,
               let date = dateFormatter.date(from: birthday){
                self.birthdayLabel.text = dateFormatter.string(from: date)
            } else {
                birthdayLabel.text = "Not available"
            }
            self.placeOfBirthdayLabel.text = self.crewViewModel?.personInfo?.placeOfBirth
            self.knowForLabel.text = self.crewViewModel?.personInfo?.knownForDepartment
        }
        self.biographyLabel.shouldCollapse = true
        self.biographyLabel.numberOfLines = 4
        self.biographyLabel.collapsedAttributedLink = NSAttributedString(
            string: "Show more", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        self.biographyLabel.expandedAttributedLink = NSAttributedString(
            string: "Show less", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        if let biographyCast = castViewModel?.personInfo?.biography {
            self.biographyLabel.text = biographyCast
        } else {
            self.biographyLabel.text = crewViewModel?.personInfo?.biography
        }
        self.setImagesForCastAndCrew()
        self.activityIndicator.stopAnimating()
    }
    private func hidePersonInformation(_ isHidden: Bool) {
        nameLabel.isHidden = isHidden
        knowsForLabel.isHidden = isHidden
        placeOfBirthdayLabel.isHidden = isHidden
        biographyLabel.isHidden = isHidden
        birthdayLabel.isHidden = isHidden
        characterImage.isHidden = isHidden
        moviesTableView.isHidden = isHidden
        knowForLabel.isHidden = isHidden
        graphyLabel.isHidden = isHidden
        moviesLabel.isHidden = isHidden
    }
    private func addButton() {
        let likeTappedButton = UIBarButtonItem(image: #imageLiteral(resourceName: "like"), style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = likeTappedButton
    }
    
    @objc
    private func addTapped() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let movieData = MovieCoreData(context: context)
        if castViewModel == nil {
            movieData.title = crewViewModel?.personInfo?.name
            movieData.image = crewViewModel?.personInfo?.profilePath
            //movieData.department = crewViewModel?.personInfo?.department
            let idPeople = Int64(crewViewModel?.personInfo?.id ?? 0)
            movieData.id = idPeople
        } else {
            movieData.title = castViewModel?.personInfo?.name
            movieData.image = castViewModel?.personInfo?.profilePath
            movieData.department = "Actor"
            let idPeople = Int64(castViewModel?.personInfo?.id ?? 0)
            movieData.id = idPeople
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "heart")
    }
}

//MARK:- Collection View extension -
extension PeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if castViewModel == nil {
            return crewViewModel?.numberOfRows() ?? 0
        } else {
            return castViewModel?.numberOfRows() ?? 0
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.imageCollectionCellIdentifier.rawValue, for: indexPath) as? ImageCollectionViewCell
        
        guard let collectionViewCell = cell else { return UICollectionViewCell()}
        
        if castViewModel == nil {
            let cellViewModel = crewViewModel?.crewCellViewModel(indexPath)
            collectionViewCell.viewModel = cellViewModel
        } else {
            let cellViewModel = castViewModel?.castCellViewModel(indexPath)
            collectionViewCell.viewModel = cellViewModel
        }
        
        return collectionViewCell
    }
    
}

extension PeopleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imagesCollectionView {
            return ImageCollectionViewCell.size
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}

//MARK:- Table View extension -
extension PeopleViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if castViewModel == nil {
            return crewViewModel?.numberOfMoviesRows() ?? 0
        } else {
            return castViewModel?.numberOfMoviesRows() ?? 0
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.moviesCellIdentifier.rawValue, for: indexPath) as? MoviesTableViewCell
        
        guard let tableViewCell = cell else { return UITableViewCell() }
        
        if castViewModel == nil {
            let cellViewModel = crewViewModel?.moviesCellViewModel(indexPath)
            
            tableViewCell.viewModel = cellViewModel
        } else {
            let cellViewModel = castViewModel?.moviesCellViewModel(indexPath)
            
            tableViewCell.viewModel = cellViewModel
        }
        
        return tableViewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = storyboard?.instantiateViewController(withIdentifier: ViewControllers.DetailMovieVCIdentifier.rawValue) as! DetailMovieViewController
        guard let viewModel = castViewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        desVC.viewModel = viewModel.idForSelectedRow()
        
        navigationController?.pushViewController(desVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
