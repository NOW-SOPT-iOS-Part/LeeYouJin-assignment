//
//  SceneDelegate.swift
//  TVING
//
//  Created by YOUJIM on 4/16/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 1. key window 설정을 위한 window 객체 할당
        self.window = UIWindow(windowScene: windowScene)
        
        // 2. LoginViewController를 rootViewController로 하는 NavigationController를 window의 rootViewController로 설정
        let navigationController = UINavigationController(rootViewController: ViewController())
        self.window?.rootViewController = navigationController
        
        // 3. window가 여러 개 존재할 때 가장 앞에 있는 window를 key window로 지정하는 함수 .makeKeyAndVisible() 호출
        self.window?.makeKeyAndVisible()
    }
}
