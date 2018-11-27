//
//  NativeLoginService.swift
//  RxMvvmExample
//
//  Created by mhmohamed on 11/26/18.
//  Copyright © 2018 mhmohamed. All rights reserved.
//

import Foundation
import  RxSwift
class NativeLoginService : LoginService {
    func signIn(userName: String, password: String) -> Observable<User> {
        return Observable.create { observer in
            /*
             Networking logic here.
             */
            
            observer.onNext(User(name : "ahmed")) // Simulation of successful user authentication.
            return Disposables.create()
        }
    }
}
