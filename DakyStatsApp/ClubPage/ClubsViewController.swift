//
//  ClubsViewController.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 11.10.2024.
//

import UIKit
import Kingfisher
import SnapKit

class ClubsViewController: UIViewController {
    
    private var tableView = UITableView()
    let clubBox = UIView()
    
    var viewModel: ClubsViewModelProtocol? {
        didSet{
            viewModel?.delegate = self
        }
    }
    
    var teamImage = UIImageView()
    var teamName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadClub()
        configureContents()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let gradient = CAGradientLayer()
        gradient.frame = clubBox.bounds
        gradient.colors = [
            UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1).cgColor,
            UIColor(red: 56/255, green: 116/255, blue: 120/255, alpha: 1).cgColor,
        ]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        clubBox.layer.insertSublayer(gradient, at: 0)
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 5.0
        gradientChangeAnimation.toValue = [
            UIColor(red: 98/255, green: 149/255, blue: 132/255, alpha: 1).cgColor,
            UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1).cgColor
            ]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")

    }
}

extension ClubsViewController {
    
    func configureContents(){
        configureView()
        configureClubBox()
        configureTeamImage()
        configureTeamName()
        configureTableView()
    }
    
    private func configureView(){
        view.backgroundColor = .white
    }
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        tableView.register(ClubPlayersCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0.0
    }
    
    private func configureClubBox() {
        view.addSubview(clubBox)
    }
    
    private func configureTeamImage(){
        guard let viewModel = viewModel else { return }
        let url = URL(string: viewModel.setClubImage())
        teamImage.kf.setImage(with: url)
        teamImage.contentMode = .scaleAspectFit
        clubBox.addSubview(teamImage)
    }
    
    private func configureTeamName() {
        guard let viewModel = viewModel else { return }
        teamName.font = .systemFont(ofSize: 24, weight: .bold)
        teamName.adjustsFontSizeToFitWidth = true
        teamName.textColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
        teamName.text = viewModel.setClubName()
        clubBox.addSubview(teamName)
    }
    
    private func setConstraints() {

        clubBox.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(clubBox.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        teamImage.snp.makeConstraints { make in
            make.centerY.equalTo(clubBox.snp.centerY)
            make.leading.equalTo(clubBox.layoutMarginsGuide.snp.leading)
            make.height.equalTo(clubBox.snp.height).multipliedBy(0.5)
            make.width.equalTo(teamImage.snp.height)
        }

        teamName.snp.makeConstraints { make in
            make.leading.equalTo(teamImage.snp.trailing).offset(16)
            make.centerY.equalTo(teamImage.snp.centerY)
        }
    }
    
}

extension ClubsViewController: ClubsViewModelDelegate {
    func handleViewModelOutput(_ output: ClubsViewModelOutput) {
        switch output {
        case .showClubPage:
            configureContents()
            setConstraints()
            tableView.reloadData()
        case .updateTitle(let title):
            self.title = title
        }
    }
    
    func navigate(to route: ClubsViewRoute) {
        switch route {
        case .playerPage(let id):
            let viewController = PlayerBuilder.make(playerId: id)
            show(viewController, sender: nil)
        }
    }
}

extension ClubsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ClubPlayersCell else { return UITableViewCell() }

        if let player = viewModel?.cellForRowAt(index: indexPath) {
            cell.configureCell(with: player)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ClubPlayersCell()
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.rowHeight)
        
        headerView.backgroundColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
        headerView.position.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        headerView.age.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        headerView.name.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        headerView.number.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.rowHeight
    }
}

extension ClubsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectRowAt(index: indexPath)
    }
}
