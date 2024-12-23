//
//  StandingsViewController.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 27.09.2024.
//

import UIKit

class StandingsViewController: UIViewController {
    
    private var tableView = UITableView()
    
    var viewModel: StandingsViewModelProtocol? {
        didSet{
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        viewModel?.loadStandings()
    }
}

extension StandingsViewController {
    
    func addSubviews(){
        addTableView()
    }
    
    func addTableView(){
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


extension StandingsViewController {
    
    func configureContents(){
        confingureView()
        configureTableView()
    }
    
    func confingureView(){
        view.backgroundColor = .white
    }
    
    func configureTableView(){
        tableView.register(StandingsCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 0.0
    }
}



extension StandingsViewController: StandingsViewModelDelegate {
    func handleViewModelOutput(_ output: StandingsViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .showTeams:
            tableView.reloadData()
        }
    }
    
    func navigate(to route: StandingsViewRoute) {
        switch route {
        case .clubPage(let id):
            let viewController = ClubBuilder.make(id: id)
            show(viewController, sender: nil)
        }
    }
}

extension StandingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let teamCount = viewModel?.numberOfRowsInSection(section: section) else { return 0 }
        return teamCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? StandingsCell else { return UITableViewCell() }
        
        if let team = viewModel?.cellForRowAt(index: indexPath) {
            cell.configureCells(with: team)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = StandingsCell()
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        headerView.backgroundColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension StandingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectRowAt(index: indexPath)
    }
}
