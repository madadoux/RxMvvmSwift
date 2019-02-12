//
//  NativeLoginService.swift
//  RxMvvmExample
//
//  Created by mhmohamed on 11/26/18.
//  Copyright © 2018 mhmohamed. All rights reserved.
//

import Foundation
import  RxSwift

enum Authentication : Error {
   case invalidCredintials (String)
}

class NativeLoginService : LoginService {
    var users =   [ "mohedsh" : "12345678" ,
                    "user1" : "12345678",
                    "user2" : "951753" ]
    
    func signIn(userName: String, password: String) -> Observable<User> {
        return Observable.create { observer in
            if let exsitUser =  self.users.first(where: { (arg0) -> Bool in
                
                let (key, value) = arg0
                return (userName == key) && (password == value)
            }) {
                observer.onNext(User(name : exsitUser.key))
            }
            else {
                observer.onError(Authentication.invalidCredintials("INVALID USER NAME OR PASSWORD PLEASE TRY LATER"))
            }
            
            return Disposables.create()
        }
    }
}
