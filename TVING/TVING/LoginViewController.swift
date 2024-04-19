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
        $0.autocorrectionType = .no // 수정 제안 끄도록 설정
        $0.spellCheckingType = .no
    }
    
    private lazy var idClearButton: UIButton = UIButton().then {
        $0.setImage(.icXmark, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(didIdClearButtonTapped), for: .touchUpInside)
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
        $0.setTitleColor(.Gray02, for: .disabled)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = $0.isEnabled ? .accent : .black
        $0.layer.borderColor = $0.isEnabled ? UIColor.clear.cgColor : UIColor.Gray04?.cgColor
        $0.addTarget(self, action: #selector(didLoginButtonTapped), for: .touchUpInside)
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
    
    // MARK: 아이디, 비밀번호 TextField의 텍스트가 !isEmpty일 때 버튼 활성화
    private func changeLoginButton() {
        if !isFieldsEmpty() {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .accent
            loginButton.layer.borderColor = UIColor.clear.cgColor
        }
        else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .black
            loginButton.layer.borderColor = UIColor.Gray04?.cgColor
        }
    }
    
    // 버튼 활성화를 위해 TextField가 비어있는지 검사하는 함수
    private func isFieldsEmpty() -> Bool {
        if idTextField.hasText && passwordTextField.hasText { return false }
        
        return true
    }
    
    @objc
    private func didLoginButtonTapped() {
        // TODO: 데이터 전송
    }
    
    @objc
    private func didIdClearButtonTapped() {
        
    }
    
    @objc
    private func didPasswordClearButtonTapped() {
        
    }
    
    // 비밀번호 마스킹 상태 토글해주는 함수
    @objc
    private func didMaskButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry { maskButton.setImage(.icEyeOff, for: .normal) }
        else { maskButton.setImage(.icEyeOn, for: .normal) }
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
        hideButton(textField)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.changeLoginButton()
        
        // 텍스트필드가 비어있지 않으면
        if textField.hasText { exposeButton(textField) }
        // 텍스트필드가 비어있으면
        else { hideButton(textField) }
    }
    
    // 지금 편집하고 있는 텍스트필드가 가지고 있는 수정 버튼들을 나타나게 설정
    func exposeButton(_ textField: UITextField) {
        if textField == idTextField { idClearButton.isHidden = false }
        if textField == passwordTextField {
            passwordClearButton.isHidden = false
            maskButton.isHidden = false
        }
    }
    
    // 지금 편집하고 있는 텍스트필드가 가지고 있는 수정 버튼들을 사라지게 설정
    func hideButton(_ textField: UITextField) {
        if textField == idTextField { idClearButton.isHidden = true }
        if textField == passwordTextField {
            passwordClearButton.isHidden = true
            maskButton.isHidden = true
        }
    }
}

