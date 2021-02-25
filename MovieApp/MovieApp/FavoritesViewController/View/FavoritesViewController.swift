//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by shizo on 04.11.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK:- Properties -
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var detailMovies: [MovieCoreData] = []
    var viewModel: FavoritesViewModelType?
    
    //MARK:- IBOutlets
    @IBOutlet weak var favoritesTableView: UITableView! {
        didSet {
            favoritesTableView.delegate = self
            favoritesTableView.dataSource = self
            
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            favoritesTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
            favoritesTableView.rowHeight = 150
            favoritesTableView.tableFooterView = UIView()
        }
    }
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoritesViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    //MARK: - Private func -
    private func getData() {
        viewModel?.getData()
        DispatchQueue.main.async {
            self.favoritesTableView.reloadData()
        }
    }
}

//MARK:- TableView extension -
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.numberOfRows() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCellIdentefier.rawValue, for: indexPath) as! MainTableViewCell
        
        let cellViewModel = viewModel?.cellFavoritesViewModel(forIndexPath: indexPath)
        
        cell.favoritesViewModel = cellViewModel
        
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let task = viewModel?.detailMovies[indexPath.row] else { return  }
            context.delete(task)
            viewModel?.detailMovies.remove(at: indexPath.row)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
         
        }
        favoritesTableView.reloadData()
    } 
}

