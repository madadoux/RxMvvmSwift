//
//  VMLogin.swift
//  RxMvvmExample
//
//  Created by mhmohamed on 11/25/18.
//  Copyright © 2018 mhmohamed. All rights reserved.
//

import Foundation
import RxSwift

struct User {
    var name : String
}

class LInput {
    
    let email: BehaviorSubject<String>
    let password: BehaviorSubject<String>
    let signInDidTap: PublishSubject<Void>
    
    init() {
        email = BehaviorSubject<String>(value: "")
        password = BehaviorSubject<String>(value: "")
        signInDidTap = PublishSubject<Void>()
    }
}
class LOutput {
    let loginResultObservable: PublishSubject<User>
    let errorsObservable: PublishSubject<Error>
    init() {
        loginResultObservable = PublishSubject<User>()
        errorsObservable = PublishSubject<Error>()
    }
}

class LoginViewModel : ViewModelProtocol {
    typealias Input = LInput
    
    typealias Output = LOutput
    
    let input : Input
    let output: Output
    let disposeBag = DisposeBag()
    var loginServices : [String : LoginService]  = [:]
    
    func addLoginService (loginService : LoginService , name : String) {
        loginServices[name] = loginService
    }

    init() {
        input = Input()
        output = Output()
        
        input.signInDidTap
            .subscribe({_  in 
                self.loginServices["native"]?
                    .signIn(userName:  try! self.input.email.value() ,
                            password: try! self.input.password.value())
                    .subscribe(onNext: {
                        (user) in
                        self.output.loginResultObservable.onNext(user)
                    }, onError: {
                        (err) in
                        self.output.errorsObservable.onNext(err)
                    }).disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
}


extension LoginViewModel  {
    func addNativeLoginService() {
        addLoginService(loginService: NativeLoginService(), name: "native")
    }
}


