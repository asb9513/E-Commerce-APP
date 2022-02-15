//
//  HomeVC.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/2/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SKActivityIndicatorView
class HomeVC: UIViewController {
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var ProductTableView: UITableView!
    var arrid : [Int]?
    var items = [CatrogyModelDatum]()
    var selectedIndex = 0
    let productViewModel = ProductViewModel()
    let branchesViewModel = BranchesViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBranches()
        subscribeToResponse()
        subscribeToLoading()
        subscribeToBranchSelection()
        subscribeToResponseproducts()
        subscribeToProductSelection()
    }
    func getBranches(){
        branchesViewModel.ShowCategories()
    }
    func subscribeToResponse() {
        self.branchesViewModel.branchesModelObservable
            .bind(to: self.CategoryCollectionView
                .rx.items(cellIdentifier: "HomeCollectionViewCell",
                          cellType: HomeCollectionViewCell.self)) { row, branch, cell in
                        print(row)
                        cell.name.text = branch.name
                        cell.configure(Product: branch)
                        
                        
            }
            .disposed(by: disposeBag)
    }
    func subscribeToLoading() {
        branchesViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                SKActivityIndicator.show()
                
            } else {
             SKActivityIndicator.dismiss()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToBranchSelection() {
        Observable
            .zip(CategoryCollectionView.rx.itemSelected, CategoryCollectionView.rx.modelSelected(CatrogyModelDatum.self))
            .bind { [weak self] selectedIndex, branch in
                self!.productViewModel.ShowProduct(id:branch.id)
                
                self?.CategoryCollectionView.reloadData()
                self?.ProductTableView.reloadData()
              
            }
            .disposed(by: disposeBag)
    }
    
    func subscribeToResponseproducts() {
        self.productViewModel.ProductModelObservable
            .bind(to: self.ProductTableView
                .rx
                .items(cellIdentifier: "productcell",
                       cellType: ProductTableViewCell.self)) { row, product, cell in
                        print(row)
                       cell.ProductName.text = product.name
                       // print("pppppprrrrrroooooodddduuuuuccccttttt\(product)")
                       cell.configure(Product: product)
                        
                        
            }
            .disposed(by: disposeBag)
  
    }
   func subscribeToProductSelection() {
        Observable
            .zip(ProductTableView.rx.itemSelected, ProductTableView.rx.modelSelected(Datum.self))
            .bind { [weak self] selectedIndex, Product in
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Details") as! DetailsVC
                self!.present(vc, animated: true, completion: nil)
                vc.ProductName.text = Product.name
                vc.configure(Product: Product)
                vc.ProductDescription.text = Product.datumDescription
                vc.productID = Product.id
                vc.price.text = "\(Product.price) EG"
               // print(selectedIndex, branch.name ?? "")
                
            }
            .disposed(by: disposeBag)
    }
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func basket(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cart") as! CartVC
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
