//
//  VCLogin.swift
//  RxMvvmExample
//
//  Created by mhmohamed on 11/25/18.
//  Copyright © 2018 mhmohamed. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class VCLogin  : UIViewController , ControllerType {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    typealias ViewModelType = LoginViewModel
    var viewModel : ViewModelType!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: viewModel)

    }
    
    func presentError(_ e:Error? ) {
        print(e ?? "")
        presentMessage(e?.localizedDescription ?? "")
    }
    
    func presentMessage(_ msg : String) {
        let alert =  UIAlertController(title: "Login", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension VCLogin {
    static func create(with viewModel: ViewModelType) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "VCLogin") as! VCLogin
        controller.viewModel = viewModel
        return controller
    }
}


extension VCLogin {
    
    func configure(with viewModel: LoginViewModel) {
        
        emailTextfield.rx.text.orEmpty
        .subscribe(viewModel.input.email)
        .disposed(by: disposeBag)
        
        passwordTextfield.rx.text.orEmpty
        .subscribe(viewModel.input.password)
        .disposed(by: disposeBag)
        
        signInButton.rx.tap.asObservable()
            .subscribe(viewModel.input.signInDidTap)
            .disposed(by: disposeBag)

         viewModel.output.errorsObservable
            .subscribe({ [unowned self] (error) in
                self.presentError(error.element)
            })
            .disposed(by: disposeBag)

        viewModel.output.loginResultObservable
            .subscribe({ [unowned self] (user) in
                self.presentMessage("User successfully signed in \(user.element?.name ?? "")")
            })
            .disposed(by: disposeBag)
        
    }
}

