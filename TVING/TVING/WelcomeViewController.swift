//
//  WelcomeViewController.swift
//  TVING
//
//  Created by YOUJIM on 4/16/24.
//

import UIKit

import SnapKit
import Then


// MARK: - Protocol

final class WelcomeViewController: UIViewController {
    
    
    // MARK: - Components
    
    private let logoImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "tvingLogo")
        $0.contentMode = .scaleAspectFill
    }
    
    private let welcomeLabel: UILabel = UILabel().then {
        $0.text = "님\n 반가워요!"
        $0.textColor = .Gray01
        $0.font = UIFont.font(.pretendardBold, ofSize: 23)
        $0.numberOfLines = 0
    }
    
    private lazy var mainButton: UIButton = UIButton().then {
        $0.setTitle("메인으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .accent
        $0.layer.cornerRadius = 3
    }
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
        setConstraint()
    }
    
    private func setUI() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        [
            logoImageView, welcomeLabel, mainButton
        ].forEach { view.addSubview($0) }
    }
    
    private func setConstraint() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(58)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(211)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(67)
            $0.centerX.equalToSuperview()
        }
        
        mainButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(66)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
}
