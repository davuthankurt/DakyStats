//
//  StatsTrackerPlayerCell.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 9.11.2024.
//

import UIKit
import SnapKit
import Kingfisher

class StatsTrackerPlayerCell: UITableViewCell {
    
    var playerRank = UILabel()
    var playerImage = UIImageView()
    var playerName = UILabel()
    var playerScore = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        contentView.addSubview(playerRank)
        contentView.addSubview(playerImage)
        contentView.addSubview(playerName)
        contentView.addSubview(playerScore)
        
        playerRank.textAlignment = .left
        playerName.textAlignment = .left
        playerScore.textAlignment = .center
        playerImage.contentMode = .scaleAspectFit
    }
    
    func setupConstraints() {
        
        playerRank.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leadingMargin)
            make.width.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        playerImage.snp.makeConstraints { make in
            make.leading.equalTo(playerRank.snp.trailing).offset(4)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        playerName.snp.makeConstraints { make in
            make.leading.equalTo(playerImage.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
        
        playerScore.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailingMargin)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    func configureCell(with footballer: PlayerPresentation, stats: Bool, index: IndexPath) {
        guard let playerStat = footballer.statistics.first else { return }
        playerName.text = footballer.player.name
        if stats == true {
            guard let goals = playerStat.goals.total else { return }
            playerScore.text = "\(goals)"
        } else {
            guard let assists = playerStat.goals.assists else { return }
            playerScore.text = "\(assists)"
        }
        guard let footballerImage = footballer.player.photo else { return }
        let url = URL(string: footballerImage)
        playerImage.kf.setImage(with: url)
        
        playerRank.text = "\(index.row + 1)."
    }
}
