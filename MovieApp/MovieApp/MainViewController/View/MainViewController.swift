//
//  ViewController.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK:- Properties -
    private var viewModel: TableViewViewModelType?
    
    //MARK:- IBOutlets-
    @IBOutlet weak var mainSegmentedControl: UISegmentedControl! {
        didSet {
            mainSegmentedControl.backgroundColor = .clear
            mainSegmentedControl.tintColor = .clear
            
            mainSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
            
            mainSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        }
    }
    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            mainTableView.delegate = self
            mainTableView.dataSource = self
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            mainTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
            mainTableView.rowHeight = 150
            
            self.tabBarController?.delegate = self
        }
    }
    //MARK:- LifeCycles-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        requestNowPlayingMovies()
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK:- IBActions-
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            requestNowPlayingMovies()
        case 1:
            requestTopRatedMovies()
        case 2:
            requestUpcomingMovies()
        default:
            break
        }
    }
    //MARK:- Private Func -
    
    private func requestNowPlayingMovies() {
        viewModel?.fetchMovies(Urls.nowPlayingMovie.rawValue) { [weak self] in
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
        }
    }
    
    private func requestTopRatedMovies() {
        viewModel?.fetchMovies(Urls.topRatedMovie.rawValue) { [weak self] in
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
        }
    }
    
    private func requestUpcomingMovies() {
        viewModel?.fetchMovies(Urls.upcomingMovie.rawValue) { [weak self] in
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
        }
    }
    
}

//MARK:- UITableView extension -
extension MainViewController: UITableViewDelegate,UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mainSegmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel?.numberOfRows() ?? 0
        case 1:
            return viewModel?.numberOfRows() ?? 0
        case 2:
            return viewModel?.numberOfRows() ?? 0
        default:
            break
        }
        return viewModel?.numberOfRows() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCellIdentefier.rawValue, for: indexPath) as? MainTableViewCell
        
        guard let tableViewcell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewcell.viewModel = cellViewModel

        return tableViewcell 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = storyboard?.instantiateViewController(identifier: ViewControllers.DetailMovieVCIdentifier.rawValue) as! DetailMovieViewController
        
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        
        desVC.viewModel = viewModel.viewModelForSelectedRow()
 
        navigationController?.pushViewController(desVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK:- TabBar extension -
extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        
        if tabBarIndex == 0 {
            self.mainTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: UITableView.ScrollPosition(rawValue: 0)!, animated: true)
        }
    }
}

