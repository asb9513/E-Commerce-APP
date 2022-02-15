//
//  File.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/1/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
import Foundation
import RxSwift
import RxCocoa
import Alamofire
class RegisterViewModel {
    var EmailBehavior = BehaviorRelay<String>(value: "")
    var PasswordBehavior = BehaviorRelay<String>(value: "")
    var NameBehavior = BehaviorRelay<String>(value: "")
    var PhoneBehavior = BehaviorRelay<String>(value: "")
    var ImageBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var registerModelSubject = PublishSubject<RegisterModel>()
    var registerModelObservable: Observable<RegisterModel> {
        return registerModelSubject
    }
    
    func Register() {
        loadingBehavior.accept(true)
        let params = [
            "name":NameBehavior.value,
            "phone":PhoneBehavior.value,
            "email": EmailBehavior.value,
            "password": PasswordBehavior.value,
            "image": ImageBehavior.value
        ]
        NetWorkManager.instance.API(method: .post, url: register,parameters:params) { [weak self](err, status, response:RegisterModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                // network error
                print(error.localizedDescription)
            }
            else {
                guard let RegisterModel = response else { return }
                self.registerModelSubject.onNext(RegisterModel)
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
