//
//  CredentialsChecker.swift
//  Navigation
//
//  Created by v.milchakova on 18.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class LoginInspector: LogInViewControllerDelegate {
    
    func auth(login: String, password: String, completion: @escaping (Bool) -> Void) {
        Checker.checkLoginAndPassword(login: login, password: password, completion: completion)
    }
    
    func isLoggedIn(completion: @escaping (Bool) -> Void) {
        Checker.isAlreadyLoggedIn(completion: completion)
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        try! Checker.signOut(completion: completion)
    }
}
