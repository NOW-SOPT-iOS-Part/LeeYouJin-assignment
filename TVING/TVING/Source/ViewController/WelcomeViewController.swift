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
        $0.textColor = UIColor.gray01
        $0.font = UIFont.font(.pretendardBold, ofSize: 23)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private lazy var mainButton: UIButton = UIButton().then {
        $0.setTitle("메인으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .accent
        $0.layer.cornerRadius = 3
        $0.addTarget(self, action: #selector(didMainButtonTapped), for: .touchUpInside)
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
    
    public func receivedData() {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("id"),
            object: nil,
            queue: nil) { result in
                let id = result.object as! String
                self.welcomeLabel.text = "\(id)님\n 반가워요!"
        }
    }
    
    @objc
    private func dataReceived(_ notification: Notification) {
        print("전송완")
        if let id = notification.object as? String {
            welcomeLabel.text = "\(id)님\n 반가워요!"
            print("적용완")
        }
        
    }
    
    @objc
    private func didMainButtonTapped() {
        self.dismiss(animated: true)
    }
}
