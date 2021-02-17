//
//  SearchViewController.swift
//  MovieApp
//
//  Created by shizo on 11.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    //MARK:- Properties -
    private var viewModel: SearchViewModelType?
    private var segment: UISegmentedControl = UISegmentedControl(items: ["Movies", "People"])
    //MARK:- IBOutlets-
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
            searchTableView.tableFooterView = UIView()
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            searchTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
            searchTableView.rowHeight = 150
        }
    }
    @IBOutlet weak var movieSearchBar: UISearchBar! {
        didSet {
            movieSearchBar.delegate = self
            movieSearchBar.showsCancelButton = true
        }
    }
    //MARK:- lifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSegment()
        viewModel = SearchViewModel()
    }
    
    //MARK:- private func-
    private func configureSegment() {
        segment.setTitle("Search Movie", forSegmentAt: 0)
        segment.sizeToFit()
        segment.selectedSegmentIndex = 0
        segment.frame.size.width = 500
        self.navigationItem.titleView = segment
        segment.addTarget(self, action: #selector(SearchViewController.indexChanged(_:)), for: .valueChanged)
        segment.backgroundColor = .clear
        segment.tintColor = .clear
        
        segment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        
        segment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "forSegmentedColor")!], for: .selected)
    }
    private func searchMovie() {
        viewModel?.fetchMovies() { [weak self ] in
            DispatchQueue.main.async {
                self?.searchTableView.reloadData()
            }
        }
    }
    private func searchPeople() {
        viewModel?.fetchPeople() { [weak self ] in
            DispatchQueue.main.async {
                self?.searchTableView.reloadData()
            }
        }
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            segment.setTitle("SearchMovies", forSegmentAt: 0)
            segment.setTitle("People", forSegmentAt: 1)
            viewModel?.searchResultsMovies = []
            viewModel?.searchResultsPeople = []
            searchTableView.reloadData()
        } else if segment.selectedSegmentIndex == 1 {
            segment.setTitle("SearchPeople", forSegmentAt: 1)
            segment.setTitle("Movies", forSegmentAt: 0)
            viewModel?.searchResultsMovies = []
            viewModel?.searchResultsPeople = []
            searchTableView.reloadData()
        }
    }
}

//MARK:- TableView extension -
extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segment.selectedSegmentIndex {
        case 0:
            return viewModel?.numberOfMoviesRows() ?? 1
        case 1:
            return viewModel?.numberOfPeopleRows() ?? 1
        default:
            break
        }
        return viewModel?.numberOfMoviesRows() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCellIdentefier.rawValue, for: indexPath) as! MainTableViewCell
        
        switch segment.selectedSegmentIndex {
        case 0:
            let cellViewModel = viewModel?.cellMoviesViewModel(forIndexPath: indexPath)
            
            cell.searchViewModel = cellViewModel
        case 1:
            let cellViewModel = viewModel?.cellPeopleViewModel(forIndexPath: indexPath)
            
            cell.peopleViewModel = cellViewModel
        default:
            return cell
        }
        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            switch segment.selectedSegmentIndex {
            case 0:
                let desVC = storyboard?.instantiateViewController(identifier: ViewControllers.DetailMovieVCIdentifier.rawValue) as! DetailMovieViewController
                
                viewModel?.selectRow(atIndexPath: indexPath)
                desVC.viewModel = viewModel?.idForMovieSelectedRow()
                navigationController?.pushViewController(desVC, animated: true)
            case 1:
                let desVC = storyboard?.instantiateViewController(identifier: ViewControllers.PeopleVCIdentifier.rawValue) as! PeopleViewController
                viewModel?.selectRow(atIndexPath: indexPath)
                desVC.crewViewModel = viewModel?.idForCrewPeopleSelectedRow()
                desVC.castViewModel = viewModel?.idForCastPeopleSelectedRow()
                navigationController?.pushViewController(desVC, animated: true)
            default:
                break
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
}

//MARK:- SearchBar extension-
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        switch segment.selectedSegmentIndex {
        case 0:
            guard let searchQuary = searchBar.text else { return }
            viewModel?.quarySearch = searchQuary
            searchMovie()
            searchTableView.reloadData()
        case 1:
            guard let searchQuary = searchBar.text else { return }
            viewModel?.quarySearch = searchQuary
            searchPeople()
            searchTableView.reloadData()
        default:
            break
        }
        if searchBar.text?.isEmpty == true {
            viewModel?.searchResultsPeople = []
            viewModel?.searchResultsMovies = []
            searchTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.searchResultsMovies = []
        viewModel?.searchResultsPeople = []
        searchTableView.reloadData()
        if searchBar.text?.isEmpty == true {
            view.endEditing(true)
        } else {
            searchBar.text? = ""
            view.endEditing(true)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
