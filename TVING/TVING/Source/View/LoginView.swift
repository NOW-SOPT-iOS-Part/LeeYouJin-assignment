//
//  LoginView.swift
//  TVING
//
//  Created by YOUJIM on 7/4/24.
//

import UIKit

import SnapKit
import Then


final class LoginView: UIView {
    
    private let loginLabel: UILabel = UILabel().then {
        $0.text = "TVING ID 로그인"
        $0.textColor = .white
        $0.font = UIFont.font(.pretendardMedium, ofSize: 23)
    }
    
    lazy var idTextField: UITextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.attributedPlaceholder = NSAttributedString(
            string: $0.placeholder!,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray02])
        $0.textColor = UIColor.gray02
        $0.font = UIFont.font(.pretendardSemiBold, ofSize: 15)
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.backgroundColor = UIColor.gray04
        $0.layer.cornerRadius = 3
        $0.autocorrectionType = .no // 수정 제안 끄도록 설정
        $0.spellCheckingType = .no
    }
    
    lazy var idClearButton: UIButton = UIButton().then {
        $0.setImage(.icXmark, for: .normal)
        $0.isHidden = true
    }
    
    lazy var passwordTextField: UITextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.attributedPlaceholder = NSAttributedString(
            string: $0.placeholder!,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray02])
        $0.isSecureTextEntry = true
        $0.textColor = UIColor.gray02
        $0.font = UIFont.font(.pretendardSemiBold, ofSize: 15)
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.backgroundColor = UIColor.gray04
        $0.layer.cornerRadius = 3
        $0.autocorrectionType = .no // 수정 제안 끄도록 설정
        $0.spellCheckingType = .no
    }
    
    lazy var passwordClearButton: UIButton = UIButton().then {
        $0.setImage(.icXmark, for: .normal)
        $0.isHidden = true
    }
    
    lazy var maskButton: UIButton = UIButton().then {
        $0.setImage(.icEyeOff, for: .normal)
        $0.isHidden = true
    }
    
    lazy var loginButton: UIButton = UIButton().then {
        $0.setTitle("로그인하기", for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemiBold, ofSize: 14)
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.isEnabled = false
        $0.setTitleColor(UIColor.gray02, for: .disabled)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = $0.isEnabled ? .accent : .black
        $0.layer.borderColor = $0.isEnabled ? UIColor.clear.cgColor : UIColor.gray04.cgColor
    }
    
    private lazy var findIdButton: UIButton = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(UIColor.gray02, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemiBold, ofSize: 14)
        $0.backgroundColor = .clear
    }
    
    private let seperateLine: UIView = UIView().then {
        $0.backgroundColor = UIColor.gray02
    }
    
    private lazy var findPasswordButton: UIButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(UIColor.gray02, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemiBold, ofSize: 14)
        $0.backgroundColor = .clear
    }
    
    private let getNicknameLabel: UILabel = UILabel().then {
        $0.text = "아직 계정이 없으신가요?"
        $0.textColor = UIColor.gray04
        $0.font = UIFont.font(.pretendardSemiBold, ofSize: 14)
    }
    
    private lazy var getNicknameButton: UIButton = UIButton().then {
        $0.setTitle("닉네임 만들러가기", for: .normal)
        $0.setTitleColor(UIColor.gray02, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardRegular, ofSize: 14)
        $0.underlineTitle(forTitle: "닉네임 만들러가기")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [
            loginLabel, idTextField, passwordTextField, loginButton, findIdButton, seperateLine,
            findPasswordButton, getNicknameLabel, getNicknameButton, passwordClearButton, maskButton,
            idClearButton
        ].forEach { self.addSubview($0) }
    }
    
    // 컴포넌트 Constraint Snapkit으로 설정
    private func setConstraint() {
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(90)
            $0.centerX.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(31)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        idClearButton.snp.makeConstraints {
            $0.centerY.equalTo(idTextField)
            $0.trailing.equalTo(idTextField.snp.trailing).inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
            $0.leading.trailing.height.equalTo(idTextField)
        }
        
        passwordClearButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextField)
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(20)
        }
        
        maskButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextField)
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(20)
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
}
