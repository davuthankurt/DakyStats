//
//  ClubPlayersCell.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 16.10.2024.
//

import UIKit
import SnapKit

class ClubPlayersCell: UITableViewCell {
    var name = UILabel()
    var age = UILabel()
    var number = UILabel()
    var position = UILabel()
    var photo = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(name)
        contentView.addSubview(age)
        contentView.addSubview(number)
        contentView.addSubview(position)
        contentView.addSubview(photo)
        
        name.text = "Name"
        name.textColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
        name.adjustsFontSizeToFitWidth = true
        age.text = "Age"
        age.textColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
        number.text = "No"
        number.textColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
        position.text = "Pos"
        position.textColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
    }
    
    private func setupConstraints() {
        
        number.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leadingMargin)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        photo.snp.makeConstraints { make in
            make.leading.equalTo(number.snp.trailing).offset(6)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40) 
        }
        
        name.snp.makeConstraints { make in
            make.leading.equalTo(photo.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        age.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        position.snp.makeConstraints { make in
            make.leading.equalTo(age.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.snp.trailingMargin)
            make.centerY.equalToSuperview()
        }
    }
    
    public func configureCell(with player: ClubPlayerCellPresentation) {
        if let playerAge = player.age{
            age.text = "\(playerAge)"
        } else {
            age.text = "_"
        }
        name.text = player.name
        
        if let playerNumber = player.number{
            number.text = "\(playerNumber)"
        } else {
            number.text = "_"
        }
        
        
        switch player.position {
        case "Goalkeeper":
            position.text = "GK"
        case "Defender":
            position.text = "DF"
        case "Midfielder":
            position.text = "MF"
        case "Attacker":
            position.text = "FW"
        default:
            position.text = "UNK"
        }
        
        guard let photoString = player.photo else { return }
        let url = URL(string: photoString)
        photo.kf.setImage(with: url)
    }
}
