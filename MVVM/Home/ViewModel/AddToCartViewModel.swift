//
//  AddToCartViewModel.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/11/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
class AddCartModelView {
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var cartModelSubject = PublishSubject<AddCartModel>()
    var cartModelObservable: Observable<AddCartModel> {
        return cartModelSubject
    }
    
    func AddToCart(id:Int?) {
        loadingBehavior.accept(true)
        let params = [
            "product_id": id,
        ]
        NetWorkManager.instance.API(method: .post, url: favorites,parameters:params as [String : Any],header: ["Authorization":"\(UserDefaults.standard.value(forKey: "TOKEN") ?? "" )"]) { [weak self](err, status, response:AddCartModel?) in
            print("ppppppppppppppppppppppppppppppppp")
            print(UserDefaults.standard.value(forKey: "TOKEN"))
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                // network error
                print(error.localizedDescription)
            }
            else {
                guard let cartModel = response else { return }
                self.cartModelSubject.onNext(cartModel)
                print(response ?? "")
            }
        }
    }
}


