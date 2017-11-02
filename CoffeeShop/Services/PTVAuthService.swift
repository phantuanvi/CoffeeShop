//
//  AuthService.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/31/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import Foundation
import Firebase

class PTVAuthService {
    static let sharedInstance = PTVAuthService()
    
    let defaults = UserDefaults.standard
    
    // Check run app the first time
    var isFirstTime: Bool? {
        get {
            return defaults.bool(forKey: DEFAULTS_FIRST_TIME) == true
        }
        set {
            defaults.set(newValue, forKey: DEFAULTS_FIRST_TIME)
        }
    }
    
    // Check when run sideBarVC
    var isMenuBlue: Bool? {
        get {
            return defaults.bool(forKey: DEFAULTS_FIRST_TIME) == true
        }
        set {
            defaults.set(newValue, forKey: DEFAULTS_FIRST_TIME)
        }
    }
    
    var isRegistered: Bool? {
        get {
            return defaults.bool(forKey: DEFAULTS_REGISTERED) == true
        }
        set {
            defaults.set(newValue, forKey: DEFAULTS_REGISTERED)
        }
    }
    
    // Check user login or not
    var isAuthenticated: Bool? {
        get {
            return defaults.bool(forKey: DEFAULTS_AUTHENTICATED) == true
        }
        set {
            defaults.set(newValue, forKey: DEFAULTS_AUTHENTICATED)
        }
    }
    
    var email: String? {
        get {
            return defaults.value(forKey: DEFAULTS_EMAIL) as? String
        }
        set {
            defaults.set(newValue, forKey: DEFAULTS_EMAIL)
        }
    }
    
    // Func: Tạo mới User
    // messageCallback (message: String, success: Bool) -> ()
    // - message: gửi error message ra ngoài
    // - success: báo tạo mới thành công hay không
    func registerUser(email: String, password: String, completion: @escaping messageCallback) {
        
        // Nếu xuất hiện error thì gửi ra bằng biến message
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(error.localizedDescription, false)
                return
            }
            // Nếu tạo mới User thành công thì gửi email xác nhận.
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                if let error = error {
                    completion(error.localizedDescription, false)
                    return
                }
                self.isRegistered = true
                completion("", true)
            })
        }
    }
    
    // Func logIn
    // callback (_ success: Bool) -> ()
    // - success: gửi ra ngoài báo logIn thành công hay ko
    func logInWith(credential: AuthCredential, completion: @escaping callback) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            PTVAuthService.sharedInstance.isAuthenticated = true
            completion(true)
        })
    }
}







