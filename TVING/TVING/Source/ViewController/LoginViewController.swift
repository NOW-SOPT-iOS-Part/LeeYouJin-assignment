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
    private let loginView = LoginView()
    
    
    // MARK: Functions
    
    // 키보드 밖을 눌렀을 때 입력 종료되도록 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setAddtarget()
        setDelegate()
    }
    
    private func setLayout() {
        view.backgroundColor = .black
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setAddtarget() {
        loginView.idClearButton.addTarget(self, action: #selector(didIdClearButtonTapped), for: .touchUpInside)
        loginView.passwordClearButton.addTarget(self, action: #selector(didPasswordClearButtonTapped), for: .touchUpInside)
        loginView.maskButton.addTarget(self, action: #selector(didMaskButtonTapped), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(didLoginButtonTapped), for: .touchUpInside)
    }
    
    // TextField Delegate 설정
    private func setDelegate() {
        loginView.idTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }

    @objc
    private func didLoginButtonTapped() {
        let welcomeVC = WelcomeViewController()
        
        // WelcomeVC에서 NotificationCenter로 id 데이터 받을 옵저버 등록
        welcomeVC.receivedData()
        
        // NotificationCenter로 id 데이터 post
        NotificationCenter.default.post(
            name: NSNotification.Name("id"),
            object: loginViewModel.id.value
        )
        
        welcomeVC.modalPresentationStyle = .fullScreen
        
        present(welcomeVC, animated: true)
    }
    
    @objc
    private func didIdClearButtonTapped() {
        loginView.idTextField.text = ""
    }
    
    @objc
    private func didPasswordClearButtonTapped() {
        loginView.passwordTextField.text = ""
    }
    
    // 비밀번호 마스킹 상태 토글해주는 함수
    @objc
    private func didMaskButtonTapped() {
        loginView.passwordTextField.isSecureTextEntry.toggle()
        
        if loginView.passwordTextField.isSecureTextEntry {
            loginView.maskButton.setImage(.icEyeOff, for: .normal)
        }
        else {
            loginView.maskButton.setImage(.icEyeOn, for: .normal)
        }
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
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if loginViewModel.updateLoginButtonStatus() {
            loginView.loginButton.isEnabled = false
            loginView.loginButton.backgroundColor = .black
            loginView.loginButton.layer.borderColor = UIColor.gray04.cgColor
        }
        else {
            loginView.loginButton.isEnabled = true
            loginView.loginButton.backgroundColor = .accent
            loginView.loginButton.layer.borderColor = UIColor.clear.cgColor
        }
        
        /// 텍스트필드 값이 바뀔 때마다 해당 값을 뷰모델의 id와 password value에 각각 할당해줘야 하는데 방법을 모르겠음
        /// 근데 이게 아닌건 알겠는데 ............ 어케해야하지 이것만 하면 끝남
        if textField == loginView.idTextField {
            loginViewModel.id.value = textField.text ?? ""
        }
        else {
            loginViewModel.password.value = textField.text ?? ""
        }
        
        shouldButtonVisibleChange()
    }
    
    // 텍스트필드의 상태에 따라 버튼 활성화 상태 변경
    func shouldButtonVisibleChange() {
        loginView.idClearButton.isHidden = loginViewModel.isIdTextFieldEmpty.value
        loginView.passwordClearButton.isHidden = loginViewModel.isPasswordTextFieldEmpty.value
    }
}

