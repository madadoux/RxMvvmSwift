//
//  Protocols.swift
//  RxMvvmExample
//
//  Created by mhmohamed on 11/25/18.
//  Copyright © 2018 mhmohamed. All rights reserved.
//

import Foundation
import  UIKit
import  RxSwift

protocol ViewModelProtocol: class {
    associatedtype Input
    associatedtype Output
}

protocol ControllerType : class {
    associatedtype ViewModelType: ViewModelProtocol
    
    func configure(with viewModel: ViewModelType)
    /// Factory function for view controller instatiation
    ///
    /// - Parameter viewModel: View model object
    /// - Returns: View controller of concrete type
    static func create(with viewModel: ViewModelType) -> UIViewController
}


protocol LoginService {
    func signIn ( userName : String , password: String) -> Observable<User>
}
