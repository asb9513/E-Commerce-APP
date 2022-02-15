//
//  CartVC.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/11/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import UIKit

import SKActivityIndicatorView
class CartVC: UIViewController {
    @IBOutlet weak var favProductTV: UITableView!
    

    var cart = [ShowCartModelDatum]()
    var idproduct:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getproduct()
        favProductTV.delegate = self
        favProductTV.dataSource = self
        favProductTV.reloadData()
       // getCartProduct()
        
      //  getBranches()
     //   subscribeToResponse()
      //  subscribeToLoading()
        // Do any additional setup after loading the view.
        floatingButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //    getBranches()
        getproduct()
        
    }
    
    func getproduct(){
        NetWorkManager.instance.API(method: .get, url:favorites,header:["Authorization":"\(UserDefaults.standard.value(forKey: "TOKEN") ?? "")"]) { [weak self](err, status, response:ShowCartModel?) in
            guard let self = self else { return }
           // self.loadingBehavior.accept(false)
            if let error = err {
                print("errroreerroorreerroorreerroorreerrrroorr  ",error.localizedDescription)
            }  else {
                guard let product = response else { return }
                
                self.cart = product.data.data
                self.favProductTV.reloadData()
               // print("pranshpranshpranshhbranshhhhhhhhhhhhh \(self.cart)")
            }
        }
    }
        func deletproduct(){
            SKActivityIndicator.show()
            NetWorkManager.instance.API(method: .delete, url: "https://student.valuxapps.com/api/favorites/\(idproduct ?? 0)",header:["Authorization":"\(UserDefaults.standard.value(forKey: "TOKEN") ?? "")"]) { [weak self](err, status, response:DeletCartModel?) in
                SKActivityIndicator.dismiss()
                if response?.status == true {
                    print(response)
                    self?.showToast(message: (response?.message)!)
                    
                }
                else {
                    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",err)
                }
                
            }
            
        }
        
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func home(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeVC
        self.present(vc, animated: true, completion: nil)
    }
 
 
    @IBAction func delet(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: favProductTV)
        guard let indexpath = favProductTV.indexPathForRow(at: point) else {return}
        self.idproduct = cart[indexpath.row].id
        
        let alert = UIAlertController(title: "Warning ", message: "Are you Sure you want to delete that ?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            DispatchQueue.main.async {
                SKActivityIndicator.show()
                NetWorkManager.instance.API(method: .delete, url: "https://student.valuxapps.com/api/favorites/\(self.idproduct ?? 0)",header:["Authorization":"\(UserDefaults.standard.value(forKey: "TOKEN") ?? "")"]) { [weak self](err, status, response:DeletCartModel?) in
                    SKActivityIndicator.dismiss()
                    if response?.status == true {
                        print(response)
                        self?.showToast(message: (response?.message)!)
                        
                    }
                    else {
                        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",err)
                    }
                    
                }
                
                self.cart.remove(at: indexpath.row)
                self.favProductTV.beginUpdates()
                self.favProductTV.deleteRows(at: [indexpath], with: .fade)
                
                
                
                self.favProductTV.endUpdates()
                self.favProductTV.reloadData()
                let alert2 = UIAlertController(title: "Delete Process ", message: "proccess done successfully", preferredStyle: .actionSheet)
                
                let cancelAction2 = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert2.addAction(cancelAction)
                self.present(alert2, animated: true, completion: nil)
                
            }
        }
        
        //Add the actions to the alert controller
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        //Present the alert controller
        present(alert, animated: true, completion: nil)
        
    }
    func floatingButton(){
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x:150, y: 700, width: 100, height: 100)
        btn.setTitle("Location", for: .normal)
        btn.backgroundColor = .orange
        
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 50
        btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.layer.borderWidth = 3.0
      //  btn.setBackgroundImage(self.image, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(goToLocation), for: .touchUpInside)
       
        view.addSubview(btn)
    }

  @objc  func goToLocation() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "location") as! Location
    self.present(vc, animated:true, completion: nil)
    }
    
}

extension CartVC:UITableViewDelegate,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FavoritTableViewCell = favProductTV.dequeueReusableCell(withIdentifier: "favorit", for: indexPath)as! FavoritTableViewCell
       cell.configure(Product: cart[indexPath.row].product)
        cell.favName.text = cart[indexPath.row].product.name
       
        return cell
    }
    
  /*  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.idproduct = cart[indexPath.row].id
         print("cccccccccccccccccccccccccccccccccc \(cart[indexPath.row].id)")    }
    */
    
}
