//
//  Checker.swift
//  Navigation
//
//  Created by v.milchakova on 18.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import FirebaseAuth

class Checker {
    static func checkLoginAndPassword(login: String, password: String, completion: @escaping (Bool) -> Void) {
        let user = FirebaseAuth.Auth.auth().currentUser
        if let myUser = user {
            print(myUser.email as Any)
            print(myUser.isAnonymous)
            print(myUser.displayName as Any)
            print(myUser.isEmailVerified)
            completion(true)
        } else {
            FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { (user, error)  in
                print("Checker checkLoginAndPassword result: \(String(describing: user?.user))")
                
                if let _ = user {
                    print("Checker checkLoginAndPassword auth success")
                    completion(true)
                } else {
                    print("Checker checkLoginAndPassword auth failed")
                    
                    if let errorCode = AuthErrorCode(rawValue: error!._code){
                    switch errorCode {
                        case.wrongPassword:
                            print("wrong password")
                            completion(false)
                        default:
                            print("default")
                            FirebaseAuth.Auth.auth().createUser(withEmail: login, password: password) { result, arg  in
                                print("Checker checkLoginAndPassword result: \(String(describing: result?.user))")
                                if let _ = result {
                                    print("Checker checkLoginAndPassword auth success")
                                    completion(true)
                                } else {
                                    print("Checker checkLoginAndPassword auth failed")
                                    completion(false)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func isAlreadyLoggedIn(completion: @escaping (Bool) -> Void) {
        let user = FirebaseAuth.Auth.auth().currentUser
        if let myUser = user {
            print(myUser.email as Any)
            print(myUser.isAnonymous)
            print(myUser.displayName as Any)
            print(myUser.isEmailVerified)
            print("Checker isAlreadyLoggedIn true")
            completion(true)
        } else {
            print("Checker isAlreadyLoggedIn false")
            completion(false)
        }
    }
    
    static func signOut(completion: @escaping (Bool) -> Void) throws {
        let user = FirebaseAuth.Auth.auth().currentUser
        if let _ = user {
            try FirebaseAuth.Auth.auth().signOut()
            print("Checker signOut")
        }
        completion(true)
    }
}
