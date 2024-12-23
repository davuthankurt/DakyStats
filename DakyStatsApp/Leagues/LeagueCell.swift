//
//  LeagueCell.swift
//  FootballApp
//
//  Created by Davuthan Kurt on 17.09.2024.
//

import UIKit
import Kingfisher

class LeagueCell: UICollectionViewCell {
    var imageView = UIImageView()
    var leagueTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(leagueTitle)
        
        imageView.contentMode = .scaleAspectFit
        
        leagueTitle.text = ""
        leagueTitle.textAlignment = .center
        leagueTitle.font = UIFont.boldSystemFont(ofSize: 16)
        leagueTitle.numberOfLines = 2
    }
    
    private func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        leagueTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            leagueTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            leagueTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            leagueTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            leagueTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureCell(with league: LeaguePresentation) {
        let url = URL(string: league.image)
        imageView.kf.setImage(with: url)
        leagueTitle.text = league.title
    }
}
