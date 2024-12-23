//
//  LeagueHeader.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 8.11.2024.
//

//    UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1).cgColor,
//    UIColor(red: 56/255, green: 116/255, blue: 120/255, alpha: 1).cgColor,
//    UIColor(red: 98/255, green: 149/255, blue: 132/255, alpha: 1).cgColor,
//    UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1).cgColor

import UIKit

class LeagueHeader: UICollectionReusableView {
    
    static let reuseIdentifier = "CustomHeaderView"
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitle()
        setTitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTitle() {
        addSubview(titleLabel)
        titleLabel.font = UIFont(name: "AvenirNext-BoldItalic", size: 20)
        titleLabel.textColor =  UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
    }
    
    func setTitleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
