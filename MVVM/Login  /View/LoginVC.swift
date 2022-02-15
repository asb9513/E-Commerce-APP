//
//  LoginVC.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/1/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SKActivityIndicatorView
class LoginVC: UIViewController {
    
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var loginviewmodel = LoginViewModel()
    var disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 15
        loginButton.layer.masksToBounds = true
       bindTextFieldsToViewModel()
       subscribeToLoading()
       subscribeToResponse()
       subscribeToLoginButton()
    }
    func bindTextFieldsToViewModel() {
        EmailTxt.rx.text.orEmpty.bind(to: loginviewmodel.EmailBehavior).disposed(by: disposebag)
        PasswordTxt.rx.text.orEmpty.bind(to: loginviewmodel.PasswordBehavior).disposed(by: disposebag)
    }
     func subscribeToLoading() {
        loginviewmodel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading == true {
              SKActivityIndicator.show()
            }
            else{
                SKActivityIndicator.dismiss()
            }
            
        }).disposed(by: disposebag)
    }
    func subscribeToLoginButton() {
        loginButton.rx.tap.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.init()).subscribe(onNext: { [weak self](_)  in
            guard let self = self else { return }
              self.loginviewmodel.Login()
        }).disposed(by: disposebag)
    }
    func subscribeToResponse() {
        loginviewmodel.LoginModelObserval.subscribe(onNext: {
            if $0.status == true{
                self.showToast(message: $0.message!)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeVC
                self.present(vc, animated: true, completion: nil)
                self.EmailTxt.text = ""
                self.PasswordTxt.text = ""
            }
            else{
                self.showToast(message: $0.message!)
            }
        }).disposed(by: disposebag)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
