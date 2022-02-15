//
//  productViewModel.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/10/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift
import Alamofire
class ProductViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    private var ProductModelSubject = PublishSubject<[Datum]>()
    
    var ProductModelObservable: Observable<[Datum]> {
        return ProductModelSubject
    }
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    func ShowProduct(id:Int?) {
        loadingBehavior.accept(true)
      /*  NetWorkManager.instance.getproduct(method: .get, url: "https://student.valuxapps.com/api/products?category_id=\(id!)") { [weak self] (response, err) in
       */
        
        NetWorkManager.instance.API(method: .get, url: "https://student.valuxapps.com/api/products?category_id=\(id!)") {[weak self] (err, status, response:ProductModel?) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = err {
                print("errrrrror json ",error.localizedDescription)
            }  else {
                guard let branchesModel = response else { return }
                if branchesModel.data.data.count > 0 {
                    self.ProductModelSubject.onNext(branchesModel.data.data )
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
