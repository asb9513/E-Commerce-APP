//
//  HomeViewModel.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/4/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
import Foundation
import RxCocoa
import RxSwift
import Alamofire
class BranchesViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    private var branchesModelSubject = PublishSubject<[CatrogyModelDatum]>()
    
    var branchesModelObservable: Observable<[CatrogyModelDatum]> {
        return branchesModelSubject
    }
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    func ShowCategories() {
        loadingBehavior.accept(true)
        NetWorkManager.instance.API(method: .get, url: categories) { [weak self](err, status, response:CatrogyModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                print(error.localizedDescription)
            }  else {
                guard let branchesModel = response else { return }
                if branchesModel.data?.data?.count ?? 0 > 0 {
                    self.branchesModelSubject.onNext(branchesModel.data?.data ?? [])
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
