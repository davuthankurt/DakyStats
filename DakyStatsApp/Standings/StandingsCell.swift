//
//  StandingsCell.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 8.10.2024.
//

import UIKit

class StandingsCell: UITableViewCell {
    
    var rank = UILabel()
    var points = UILabel()
    var teamName = UILabel()
    var records = UILabel()
    var goalsDiff = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureContents() {
        configureRank()
        configureName()
        configurePoints()
        configureGoalsDiff()
        configureGamesPlayed()
    }

    private func configureRank(){
        contentView.addSubview(rank)
        
        rank.text = "R"
        rank.textAlignment = .left
        rank.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
    }
    
    private func configureName(){
        contentView.addSubview(teamName)
        
        teamName.text = "Team"
        teamName.textAlignment = .left
        teamName.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
    }
    
    private func configurePoints(){
        contentView.addSubview(points)
        
        points.text = "P"
        points.textAlignment = .center
        points.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
    }
    
    private func configureGoalsDiff(){
        contentView.addSubview(goalsDiff)
        
        goalsDiff.text = "Av"
        goalsDiff.textAlignment = .center
        goalsDiff.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
    }
    
    private func configureGamesPlayed(){
        contentView.addSubview(records)
        
        records.text = "G"
        records.textAlignment = .center
        records.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
    }
    private func setupConstraints() {
        rank.translatesAutoresizingMaskIntoConstraints = false
        teamName.translatesAutoresizingMaskIntoConstraints = false
        points.translatesAutoresizingMaskIntoConstraints = false
        goalsDiff.translatesAutoresizingMaskIntoConstraints = false
        records.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            rank.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            rank.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rank.widthAnchor.constraint(equalToConstant: 30),
            teamName.leadingAnchor.constraint(equalTo: rank.trailingAnchor, constant: 8),
            teamName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamName.widthAnchor.constraint(equalToConstant: 150),
            points.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            points.leadingAnchor.constraint(equalTo: goalsDiff.trailingAnchor, constant: 8),
            points.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            points.widthAnchor.constraint(equalToConstant: 30),
            goalsDiff.trailingAnchor.constraint(equalTo: points.leadingAnchor, constant: -8),
            goalsDiff.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            goalsDiff.widthAnchor.constraint(equalToConstant: 30),
            records.trailingAnchor.constraint(equalTo: goalsDiff.leadingAnchor, constant: -8),
            records.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            records.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    public func configureCells(with team: StandingsCellPresentation) {
        rank.textColor = .black
        teamName.textColor = .black
        goalsDiff.textColor = .black
        points.textColor = .black
        records.textColor = .black
        
        rank.text = "\(team.rank)."
        teamName.text = team.team
        goalsDiff.text = "\(team.goalsDiff)"
        points.text = "\(team.points)"
        records.text = "\(team.gamesPlayed)"
    }
}
