//
//  RegisterViewModel.swift

import Foundation
import RxCocoa
import RxSwift
class RegisterViewModel {
     var nameBehavior = BehaviorRelay<String>(value:"")
     var emailBehavior = BehaviorRelay<String>(value:"")
     var addressBehavior = BehaviorRelay<String>(value:"")
     var phoneBhavior = BehaviorRelay<String>(value:"")
     var passwordBehavior = BehaviorRelay<String>(value:"")
     var confirmpasswordBehavior = BehaviorRelay<String>(value:"")
     var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var RegisterModelSubject = PublishSubject<RegisterModel>()
    var registerModelObserval:Observable<RegisterModel>{
        
        return RegisterModelSubject
    }
    func registerClicked(){
        let params = ["name":nameBehavior.value,
                      "email":emailBehavior.value,
                      "phone":phoneBhavior.value,
                      "password":passwordBehavior.value,
                      "confirm_password":confirmpasswordBehavior.value,
                      "address":addressBehavior.value
                      ]
 NetWorkManager.instance.API(method: .post, url: Register,parameters:params) { (err, status, response: RegisterModel?)  in
   
    if let err = err {
        self.loadingBehavior.accept(false)
    }
    else {
        guard let response = response else {return}
        self.RegisterModelSubject.onNext(response)
        UserDefaults.standard.set(response.data?.id, forKey: "IDUSER")
        UserDefaults.standard.set(response.data?.name, forKey: "NAMEUSER")
        UserDefaults.standard.set(response.data?.phone, forKey: "NAMEPHONE")
        UserDefaults.standard.set(response.data?.email, forKey: "NAMEEMAIL")
        UserDefaults.standard.set(response.data?.address, forKey: "NAMEADRESS")
        UserDefaults.standard.synchronize()
        
        
     }
    }
  }
}
