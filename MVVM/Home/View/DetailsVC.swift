//
//  DetailsVC.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/11/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift
import SKActivityIndicatorView
class DetailsVC: UIViewController {
    @IBOutlet weak var imgproduct: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var ProductDescription: UITextView!
    @IBOutlet weak var AddCart: UIButton!
    let CartViewModel = AddCartModelView()
    var productID:Int?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        AddCart.layer.cornerRadius = 15
        AddCart.layer.masksToBounds = true
        ProductDescription.layer.cornerRadius = 20
        ProductDescription.layer.masksToBounds = true
        ProductDescription.layer.shadowRadius = 8.0
         ProductDescription.layer.shadowColor = UIColor.black.cgColor        // Do any additional setup after loading the view.
        subscribeToLoading()
        subscribeToResponse()
        subscribeToAddCartButton()
    }
    

    func configure(Product: Datum) {
        
        if let img = URL(string: Product.image ){
            DispatchQueue.main.async {
                
                self.imgproduct.kf.setImage(with: img)
                
            }
        }
    }
    func subscribeToLoading() {
        CartViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                SKActivityIndicator.show()
                
            } else {
                SKActivityIndicator.dismiss()
                
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        CartViewModel.cartModelObservable.subscribe(onNext: {
            if $0.status == true {
                self.showToast(message: $0.message!)            }
            else {
                self.showToast(message: $0.message!)
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToAddCartButton() {
        AddCart.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.CartViewModel.AddToCart(id:self.productID )
               
            }).disposed(by: disposeBag)
    }
    
    @IBAction func addcartaction(_ sender: Any) {
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func basket(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cart") as! CartVC
        self.present(vc, animated: true, completion: nil)    }
}
    
    

