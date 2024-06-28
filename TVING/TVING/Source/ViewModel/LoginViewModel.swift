//
//  LoginViewModel.swift
//  TVING
//
//  Created by YOUJIM on 6/5/24.
//

import UIKit


class LoginViewModel {
    var id: String = ""
    var password: String = ""
    
    func updateFieldValue(_ textField: UITextField) {
        if textField.placeholder == "아이디" {
            id = textField.text ?? ""
        }
        else {
            password = textField.text ?? ""
        }
    }
    
    func clearValue(_ textField: UITextField) {
        textField.text = ""
    }
    
    func updateLoginButtonStatus(_ loginButton: UIButton) {
        if id.isEmpty || password.isEmpty {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .black
            loginButton.layer.borderColor = UIColor.gray04.cgColor
        }
        else {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .accent
            loginButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func updateMask(_ maskButton: UIButton, _ passwordTextField: UITextField) {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry { maskButton.setImage(.icEyeOff, for: .normal) }
        else { maskButton.setImage(.icEyeOn, for: .normal) }
    }
    
    func pushToWelcomeVC(_ viewController: UIViewController) {
        let welcomeVC = WelcomeViewController()
        
        // WelcomeVC에서 NotificationCenter로 id 데이터 받을 옵저버 등록
        welcomeVC.receivedData()
        
        // NotificationCenter로 id 데이터 post
        NotificationCenter.default.post(
            name: NSNotification.Name("id"),
            object: id
        )
        
        welcomeVC.modalPresentationStyle = .fullScreen
        
        viewController.present(welcomeVC, animated: true)
    }
}
