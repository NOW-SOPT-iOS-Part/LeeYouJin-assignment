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
    
    
    // MARK: - Components
    
    private let loginViewModel = LoginViewModel()
    
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
    
    private lazy var idClearButton: UIButton = UIButton().then {
        $0.setImage(.icXmark, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(didIdClearButtonTapped), for: .touchUpInside)
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
    
    private lazy var passwordClearButton: UIButton = UIButton().then {
        $0.setImage(.icXmark, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(didPasswordClearButtonTapped), for: .touchUpInside)
    }
    
    private lazy var maskButton: UIButton = UIButton().then {
        $0.setImage(.icEyeOff, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(didMaskButtonTapped), for: .touchUpInside)
    }
    
    private lazy var loginButton: UIButton = UIButton().then {
        $0.setTitle("로그인하기", for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemiBold, ofSize: 14)
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.isEnabled = false
        $0.setTitleColor(UIColor.gray02, for: .disabled)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = $0.isEnabled ? .accent : .black
        $0.layer.borderColor = $0.isEnabled ? UIColor.clear.cgColor : UIColor.gray04.cgColor
        $0.addTarget(self, action: #selector(didLoginButtonTapped), for: .touchUpInside)
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
    
    
    // MARK: Functions
    
    // 키보드 밖을 눌렀을 때 입력 종료되도록 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setDelegate()
        setConstraint()
    }
    
    // 배경색 설정
    private func setUI() {
        view.backgroundColor = .black
    }
    
    // view에 컴포넌트들 추가
    private func setLayout() {
        [
            loginLabel, idTextField, passwordTextField, loginButton, findIdButton, seperateLine,
            findPasswordButton, getNicknameLabel, getNicknameButton, passwordClearButton, maskButton,
            idClearButton
        ].forEach { view.addSubview($0) }
    }
    
    // TextField Delegate 설정
    private func setDelegate() {
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // 컴포넌트 Constraint Snapkit으로 설정
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
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(56)
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
    
    // 버튼 활성화를 위해 TextField가 비어있는지 검사하는 함수

    private func isFieldEmpty() -> Bool {
        return !(idTextField.hasText && passwordTextField.hasText)
    }
    
    @objc
    private func didLoginButtonTapped() {
        loginViewModel.pushToWelcomeVC(self)
    }
    
    @objc
    private func didIdClearButtonTapped() {
        loginViewModel.clearValue(idTextField)
    }
    
    @objc
    private func didPasswordClearButtonTapped() {
        loginViewModel.clearValue(passwordTextField)
    }
    
    // 비밀번호 마스킹 상태 토글해주는 함수
    @objc
    private func didMaskButtonTapped() {
        loginViewModel.updateMask(maskButton, passwordTextField)
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray02.cgColor
        
        return true
    }

    // 텍스트필드 활성화되지 않으면 border 컬러 수정하고 오른쪽 버튼 숨김
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
        shouldButtonVisibleChange(textField)
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        loginViewModel.updateFieldValue(textField)
        loginViewModel.updateLoginButtonStatus(loginButton)
        shouldButtonVisibleChange(textField)
    }
    
    // 텍스트필드의 상태에 따라 버튼 활성화 상태 변경
    func shouldButtonVisibleChange(_ textField: UITextField) {
        if textField == idTextField { idClearButton.isHidden = !textField.hasText }
        if textField == passwordTextField {
            passwordClearButton.isHidden = !textField.hasText
            maskButton.isHidden = !textField.hasText
        }
    }
}

