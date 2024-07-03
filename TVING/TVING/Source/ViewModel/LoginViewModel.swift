//
//  LoginViewModel.swift
//  TVING
//
//  Created by YOUJIM on 6/5/24.
//

import UIKit


class LoginViewModel {
    var id = Observable(value: "")
    var password = Observable(value: "")
    var isIdTextFieldEmpty = Observable(value: true)
    var isPasswordTextFieldEmpty = Observable(value: true)
    
    
    init() {
        setValues()
    }
    
    func setValues() {
        id.bind { id in
            self.updateIdTextFieldStatus(id: id)
        }
        password.bind { password in
            self.updatePasswordTextFieldStatus(password: password)
        }
    }
    
    func updateIdTextFieldStatus(id: String) {
        if id == "" {
            self.isIdTextFieldEmpty.value = true
        }
        else {
            self.isIdTextFieldEmpty.value = false
        }
    }
    
    func updatePasswordTextFieldStatus(password: String) {
        if password == "" {
            self.isPasswordTextFieldEmpty.value = true
        }
        else {
            self.isPasswordTextFieldEmpty.value = false
        }
    }
    
    func updateLoginButtonStatus() -> Bool {
        if id.value.isEmpty || password.value.isEmpty {
            return true
        }
        else {
            return false
        }
    }
}
