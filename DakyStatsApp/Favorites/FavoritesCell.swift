//
//  FavoritesCell.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 6.12.2024.
//

import UIKit
import Kingfisher
import SnapKit

class FavoritesCell: UITableViewCell {
    
    var nameLabel = UILabel()
    var photoView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        configureName()
        configureImage()
    }
    
    private func configureName() {
        contentView.addSubview(nameLabel)
        
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.textColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
    }
    
    private func configureImage() {
        contentView.addSubview(photoView)
        
        photoView.contentMode = .scaleAspectFit
    }
    
    private func setConstraints() {
        photoView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.top.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(photoView.snp.right)
            make.centerY.equalTo(contentView)
        }
    }
    
    public func configureCell(favorite: FavoritesPresentation){
        guard let name = favorite.name, let photoUrl = favorite.photo else { return }
        nameLabel.text = name
        let url = URL(string: photoUrl)
        photoView.kf.setImage(with: url)
    }
}
