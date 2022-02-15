//
//  CartViewModel.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/11/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
class ShowCartModelView {
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    private var branchesModelSubject = PublishSubject<[ShowCartModelDatum]>()
    
    var branchesModelObservable: Observable<[ShowCartModelDatum]> {
        return branchesModelSubject
    }
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    func ShowFav() {
        loadingBehavior.accept(true)
        NetWorkManager.instance.API(method: .get, url:favorites,header:["Authorization":"\(UserDefaults.standard.value(forKey: "TOKEN") ?? "")"]) { [weak self](err, status, response:ShowCartModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                print("errroreerroorreerroorreerroorreerrrroorr  ",error.localizedDescription)
            }  else {
                guard let branchesModel = response else { return }
                print("pranshpranshpranshhbranshhhhhhhhhhhhh \(branchesModel)")
                if branchesModel.data.data.count ?? 0 > 0 {
                    self.branchesModelSubject.onNext(branchesModel.data.data ?? [])
                    print("mooooooooooooooooooooooooooooooodel \(self.branchesModelSubject)")
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}

