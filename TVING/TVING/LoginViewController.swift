//
//  LoginViewController.swift
//  TVING
//
//  Created by YOUJIM on 4/16/24.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    
    // MARK: Components
    
    private let loginLabel: UILabel = UILabel().then {
        $0.text = "TVING ID 로그인"
        $0.textColor = .white
        $0.font = UIFont.font(.pretendardMedium, ofSize: 23)
    }
    
    private lazy var idTextField: UITextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.attributedPlaceholder = NSAttributedString(
            string: $0.placeholder!, 
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Gray02!])
        $0.textColor = .Gray02
        $0.font = UIFont.font(.pretendardSemiBold, ofSize: 15)
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.backgroundColor = .Gray04
        $0.layer.cornerRadius = 3
    }
    
    private lazy var passwordTextField: UITextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.attributedPlaceholder = NSAttributedString(
            string: $0.placeholder!,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Gray02!])
        $0.isSecureTextEntry = true
        $0.textColor = .Gray02
        $0.font = UIFont.font(.pretendardSemiBold, ofSize: 15)
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.backgroundColor = .Gray04
        $0.layer.cornerRadius = 3
    }
    
    private lazy var loginButton: UIButton = UIButton().then {
        $0.setTitle("로그인하기", for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemiBold, ofSize: 14)
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.isEnabled = false
        $0.setTitleColor(.Gray02, for: .disabled)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = $0.isEnabled ? .accent : .black
        $0.layer.borderColor = $0.isEnabled ? UIColor.clear.cgColor : UIColor.Gray04?.cgColor
    }
    
    private lazy var findIdButton: UIButton = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(.Gray02, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemiBold, ofSize: 14)
        $0.backgroundColor = .clear
    }
    
    private let seperateLine: UIView = UIView().then {
        $0.backgroundColor = .Gray04
    }
    
    private lazy var findPasswordButton: UIButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(.Gray02, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemiBold, ofSize: 14)
        $0.backgroundColor = .clear
    }
    
    private let getNicknameLabel: UILabel = UILabel().then {
        $0.text = "아직 계정이 없으신가요?"
        $0.textColor = .Gray04
        $0.font = UIFont.font(.pretendardSemiBold, ofSize: 14)
    }
    
    private lazy var getNicknameButton: UIButton = UIButton().then {
        $0.setTitle("닉네임 만들러가기", for: .normal)
        $0.setTitleColor(.Gray02, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardRegular, ofSize: 14)
        $0.underlineTitle(forTitle: "닉네임 만들러가기")
    }
    
    
    // MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setDelegate()
        setConstraint()
    }
    
    private func setUI() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        [
            loginLabel, idTextField, passwordTextField, loginButton, findIdButton, seperateLine,
            findPasswordButton, getNicknameLabel, getNicknameButton
        ].forEach { view.addSubview($0) }
    }
    
    private func setDelegate() {
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setConstraint() {
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(90)
            $0.centerX.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(31)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
            $0.leading.trailing.height.equalTo(idTextField)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(21)
            $0.leading.trailing.height.equalTo(idTextField)
        }
        
        findIdButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(85)
        }
        
        seperateLine.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(findIdButton)
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(85)
            $0.centerY.equalTo(findIdButton)
        }
        
        getNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(findIdButton.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(51)
        }
        
        getNicknameButton.snp.makeConstraints {
            $0.centerY.equalTo(getNicknameLabel)
            $0.trailing.equalToSuperview().inset(67)
        }
    }
    

    public func changeLoginButton() {
        if !isFieldsEmpty() {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .accent
            loginButton.layer.borderColor = UIColor.clear.cgColor
        }
        else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .black
            loginButton.layer.borderColor = UIColor.Gray02?.cgColor
        }
    }
    
    private func isFieldsEmpty() -> Bool {
        if idTextField.hasText && passwordTextField.hasText { return false }
        
        return true
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.Gray02?.cgColor
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.changeLoginButton()
    }
}

