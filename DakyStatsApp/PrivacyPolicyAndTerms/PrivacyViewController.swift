//
//  PolicyViewController.swift
//  DakyStatsApp
//
//  Created by Davuthan Kurt on 1.01.2025.
//

import UIKit
import SafariServices
import SnapKit

class PrivacyViewController: UIViewController {
    var viewModel: PrivacyViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var privacyPolicy = UIButton(type: .system)
    var termsConditions = UIButton(type: .system)
    var getStart = UIButton(type: .roundedRect)
    var welcomeMessage = UILabel()
    var appTitle = UILabel()
    var buttonContainer = UIView()
    var backgroundImage = UIImageView(image: UIImage(named: "PrivacyBackground"))
    var approvalLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        setConstraints()
    }
}

extension PrivacyViewController {
    
    private func configureContents(){
        configureView()
        configureImage()
        configureContainer()
        configureAppTitle()
        configureWelcome()
        configureStartButton()
        configureApproval()
        configurePrivacy()
        configureTerms()
    }
    
    private func configureView(){
        view.backgroundColor = UIColor(red: 19/255, green: 29/255, blue: 36/255, alpha: 1)
    }
    
    private func configureImage(){
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        backgroundImage.contentMode = .scaleAspectFill
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.2).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.addSublayer(gradientLayer)
    }
    
    private func configureContainer(){
        view.addSubview(buttonContainer)
    }
    
    private func configureAppTitle(){
        view.addSubview(appTitle)
        
        appTitle.text = "DAKY STATS"
        appTitle.font = .systemFont(ofSize: 44, weight: .bold)
        appTitle.textColor = .white
        appTitle.textAlignment = .left
    }
    
    private func configureWelcome() {
        view.addSubview(welcomeMessage)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        let attributedText = NSAttributedString(
            string: "Welcome to Daky Stats. To take a closer look on the best football leagues in the world, click Get Started whenever you are ready.",
            attributes: [
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 18)
            ])
        
        welcomeMessage.attributedText = attributedText
        welcomeMessage.numberOfLines = 5
        welcomeMessage.textAlignment = .center
    }
    
    private func configureStartButton(){
        view.addSubview(getStart)
        
        getStart.setTitle("Get Started", for: .normal)
        getStart.setTitleColor(.black, for: .normal)
        getStart.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        getStart.backgroundColor = .white
        getStart.layer.cornerRadius = 10
        
        getStart.addTarget(self, action: #selector(launchApp), for: .touchUpInside)
    }
    
    @objc func launchApp(){
        guard let viewModel = viewModel else { return }
        viewModel.launchApp()
    }
    
    private func configureApproval() {
        buttonContainer.addSubview(approvalLabel)
        
        approvalLabel.text = "By using this app you agree to"
        approvalLabel.font = .systemFont(ofSize: 12)
        approvalLabel.textColor = .lightGray
    }
    
    private func configurePrivacy(){
        buttonContainer.addSubview(privacyPolicy)
        
        let attributedString = NSAttributedString(
            string: "Privacy Policy",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 12),
                .underlineColor: UIColor.lightGray,
                .foregroundColor: UIColor.lightGray
            ])

        privacyPolicy.setAttributedTitle(attributedString, for: .normal)
        privacyPolicy.addTarget(self, action: #selector(showPrivacy), for: .touchUpInside)
    }
        
    private func configureTerms(){
        buttonContainer.addSubview(termsConditions)
        let attributedString = NSAttributedString(
            string: "Terms & Conditions",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.lightGray
            ])
        termsConditions.setAttributedTitle(attributedString, for: .normal)
        termsConditions.addTarget(self, action: #selector(showTerms), for: .touchUpInside)
    }
    
    @objc func showPrivacy(){
        guard let viewModel = viewModel else { return }
        viewModel.openPrivacy()
    }
    
    @objc func showTerms(){
        guard let viewModel = viewModel else { return }
        viewModel.openTerms()
    }
    
    private func setConstraints(){
                
        appTitle.snp.makeConstraints { make in
            make.left.equalTo(view.layoutMarginsGuide)
            make.top.equalTo(view.layoutMarginsGuide).offset(24)
        }
        
        buttonContainer.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
        }
        
        approvalLabel.snp.makeConstraints { make in
            make.top.centerX.equalTo(buttonContainer)
        }
        
        privacyPolicy.snp.makeConstraints { make in
            make.leading.equalTo(buttonContainer.snp.leading)
            make.top.equalTo(approvalLabel.snp.bottom)
            make.bottom.equalTo(buttonContainer)
        }
            
        termsConditions.snp.makeConstraints { make in
            make.leading.equalTo(privacyPolicy.snp.trailing).offset(32)
            make.trailing.equalTo(buttonContainer.snp.trailing)
            make.top.equalTo(approvalLabel.snp.bottom)
            make.bottom.equalTo(buttonContainer)
        }
        
        getStart.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(buttonContainer.snp.top).offset(-24)
            make.width.equalTo(view).dividedBy(2)
            make.height.equalTo(60)
        }
        
        welcomeMessage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.left.right.equalTo(view.layoutMarginsGuide)
            make.bottom.equalTo(getStart.snp.top).offset(-24)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(welcomeMessage.snp.bottom)
        }
    }
}

extension PrivacyViewController: PrivacyViewModelDelegate {
    
    func showSafari(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .overCurrentContext
        present(safariVC, animated: true)
    }
    
    func navigateToMainScreen() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        app.router.start(window: window)
    }
}
