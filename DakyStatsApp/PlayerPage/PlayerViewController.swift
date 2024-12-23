//
//  PlayerViewController.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 26.10.2024.
//

import UIKit

class PlayerViewController: UIViewController {
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let playerBox = UIView()
    var playerImage = UIImageView()
    var playerName = UILabel()
    var pickerView = UIPickerView()
    var competition = UIButton()
    let configButtonSymbol = UIImage.SymbolConfiguration(pointSize: 10, weight: .regular)
    var stackView = UIStackView()
    
    var viewModel: PlayerViewModelProtocol? {
        didSet {
            viewModel?.delegete = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadPlayer()
        viewModel?.setProfileData()
        configureContents()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let gradient = CAGradientLayer()
        gradient.frame = playerBox.bounds
        gradient.colors = [
            UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1).cgColor,
            UIColor(red: 56/255, green: 116/255, blue: 120/255, alpha: 1).cgColor,
        ]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        playerBox.layer.insertSublayer(gradient, at: 0)
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        playerImage.layer.cornerRadius = playerImage.frame.size.width / 2
        playerImage.layer.masksToBounds = true
    }
}

extension PlayerViewController {
    
    private func configureContents(){
        configureRightBarButton()
        configureView()
        configureStackView()
        configurePlayerBox()
        configurePlayerImage()
        configurePlayerName()
        configureCompetition()
        configureCollectionView()
        configurePicker()
    }
    
    private func configureView(){
        view.backgroundColor = .white
    }
    
    private func configureRightBarButton(){
        guard let viewModel = viewModel else { return }
        viewModel.setRightBarButtonImage { [weak self] image in
            guard let self else { return }
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: image), style: .done, target: self, action: #selector(self.favoritesButton))
        }
    }
    private func configureStackView(){
        view.addSubview(stackView)
        
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
    }
    private func configurePicker() {
        stackView.addArrangedSubview(pickerView)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        pickerView.backgroundColor = UIColor(red: 19/255, green: 29/255, blue: 36/255, alpha: 1)
        pickerView.tintColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
    }
    private func configureCompetition() {
        stackView.addArrangedSubview(competition)

        competition.backgroundColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
        competition.titleLabel?.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        competition.titleLabel?.textAlignment = .center
        competition.tintColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        competition.setTitle("Profile", for: .normal)
        competition.contentHorizontalAlignment = .center
        competition.contentVerticalAlignment = .center
        competition.layer.cornerRadius = 0
        
        competition.setImage(UIImage(systemName: "arrowtriangle.right.fill", withConfiguration: configButtonSymbol), for: .normal)
        competition.semanticContentAttribute = .forceRightToLeft
        competition.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        competition.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
    }

    private func configureCollectionView() {
        stackView.addArrangedSubview(collectionView)

        collectionView.register(PlayerCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 19/255, green: 29/255, blue: 36/255, alpha: 1)
    }
    
    private func configurePlayerBox() {
        stackView.addArrangedSubview(playerBox)
    }
    
    private func configurePlayerImage(){
        guard let viewModel = viewModel else { return }
        let url = URL(string: viewModel.setPlayerImage())
        playerImage.kf.setImage(with: url)
        playerImage.contentMode = .scaleAspectFill
        playerImage.clipsToBounds = true
        playerBox.addSubview(playerImage)
    }
    
    private func configurePlayerName() {
        guard let viewModel = viewModel else { return }
        playerName.font = .systemFont(ofSize: 20, weight: .semibold)
        playerName.adjustsFontSizeToFitWidth = true
        playerName.minimumScaleFactor = 0.5
        playerName.textColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
        playerName.text = viewModel.setPlayerName()
        playerBox.addSubview(playerName)
    }
    
    private func setConstraints() {
        playerBox.translatesAutoresizingMaskIntoConstraints = false
        playerImage.translatesAutoresizingMaskIntoConstraints = false
        playerName.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        competition.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            playerBox.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.2),
            playerImage.topAnchor.constraint(equalTo: playerBox.layoutMarginsGuide.topAnchor, constant: 2),
            playerImage.centerXAnchor.constraint(equalTo: playerBox.centerXAnchor),
            playerImage.heightAnchor.constraint(equalTo: playerBox.heightAnchor, multiplier: 0.7),
            playerImage.widthAnchor.constraint(equalTo: playerImage.heightAnchor),
            playerName.centerXAnchor.constraint(equalTo: playerBox.centerXAnchor),
            playerName.topAnchor.constraint(equalTo: playerImage.bottomAnchor, constant: 2),
            competition.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension PlayerViewController {
    @objc func favoritesButton() {
        guard let viewModel = viewModel else { return }
        viewModel.addRemoveFavorite { [weak self] image in
            guard let self else { return }
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: image)
        }
    }
}

extension PlayerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if competition.titleLabel?.text == "Profile" {
            return 4
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PlayerCell else { return UICollectionViewCell() }
        
        guard let viewModel = viewModel else { return cell }
        if competition.titleLabel?.text == "Profile" {
            cell.configureCell(title: viewModel.playerProfile[indexPath.item].title, value: viewModel.playerProfile[indexPath.item].value)
        } else {
            cell.configureCell(title: viewModel.playerStat[indexPath.item].title, value: viewModel.playerStat[indexPath.item].value)
        }
        return cell
    }
    
    @objc func handleButton(_ sender: UIButton) {
        
        pickerView.isHidden.toggle()
        if pickerView.isHidden {
            competition.setImage(UIImage(systemName: "arrowtriangle.right.fill", withConfiguration: configButtonSymbol), for: .normal)
        } else {
            competition.setImage(UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: configButtonSymbol), for: .normal)
        }
        collectionView.reloadData()
    }
}


extension PlayerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 32
        let cellWidth = (collectionView.frame.width - padding) / 2
        return CGSize(width: cellWidth, height: cellWidth * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
    }
}


extension PlayerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let viewModel = viewModel else { return 0}
        return viewModel.numberOfRowsInComponent()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let viewModel = viewModel else { return "" }
        return viewModel.titleForRow(row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let viewModel = viewModel else { return }
        competition.setTitle(viewModel.titleForRow(row: row), for: .normal)
        competition.resignFirstResponder()
        collectionView.reloadData()
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = viewModel?.titleForRow(row: row)
        label.textColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        label.textAlignment = .center
        
        return label
    }
}


extension PlayerViewController: PlayerViewModelDelegate {
    func handleViewModelOutput(_ output: PlayerViewModelOutput) {
        switch output{
        case .showPlayerPage:
            configureContents()
            setConstraints()
            collectionView.reloadData()
        case .updateTitle(let title):
            self.title = title
        }
    }
}
