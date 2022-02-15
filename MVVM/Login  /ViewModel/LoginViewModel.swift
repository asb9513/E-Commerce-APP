//
//  LoginViewModel.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/1/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
class LoginViewModel {
    var EmailBehavior = BehaviorRelay<String>(value: "")
    var PasswordBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var loginModelSubject = PublishSubject<LoginModel>()
    var LoginModelObserval:Observable<LoginModel>{
        return loginModelSubject
    }
    func Login(){
        loadingBehavior.accept(true)
        let params = [
            "email": EmailBehavior.value,
            "password": PasswordBehavior.value,
        ]
        NetWorkManager.instance.API(method: .post, url: login,parameters:params) { [weak self](err, status, response:LoginModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                // network error
                print(error.localizedDescription)
            }
            else {
                guard let loginModel = response else { return }
                self.loginModelSubject.onNext(loginModel)
                print(response ?? "")
                 UserDefaults.standard.set(response?.data?.token, forKey: "TOKEN")
                UserDefaults.standard.set(response?.data?.id, forKey: "IDUSER")
                UserDefaults.standard.set(response?.data?.name, forKey: "NAMEUSER")
                UserDefaults.standard.set(response?.data?.phone, forKey: "NAMEPHONE")
                UserDefaults.standard.set(response?.data?.email, forKey: "NAMEEMAIL")
                UserDefaults.standard.synchronize()
                
            }
        }
    }
    
    
    
}
