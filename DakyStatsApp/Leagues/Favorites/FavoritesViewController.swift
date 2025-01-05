//
//  FavoritesViewController.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 6.12.2024.
//

import UIKit
import SnapKit

class FavoritesViewController: UIViewController {
    
    var tableView = UITableView()
    var viewModel: FavoritesViewModelProtocol? {
        didSet{
            viewModel?.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.updateTitle()
        configureContents()
        setConstraints()
    }
}

extension FavoritesViewController{
    func configureContents() {
        configureView()
        configureTableView()
    }
    
    func configureView(){
        view.backgroundColor = .white
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 0.0
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setConstraints(){
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view)
        }
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel,
              let rowNumber = viewModel.numberOfRowsInSection else { return 0 }
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? FavoritesCell,
              let viewModel = viewModel
        else { return UITableViewCell()}
        cell.configureCell(favorite: viewModel.cellForRowAt(index: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectRowAt(index: indexPath)
    }
}


extension FavoritesViewController: FavoritesViewModelDelegate {
    func navigate(to route: FavoritesRoute) {
        switch route {
        case .playerPage(let id):
            let vc = PlayerBuilder.make(playerId: id)
            show(vc, sender: nil)
        }
    }
    
    func handleViewModelOutput(_ output: FavoritesViewModelOutput) {
        switch output {
        case .showFavorites:
            tableView.reloadData()
        case .updateTitle(let title):
            self.navigationItem.title = title
        }
    }
}
