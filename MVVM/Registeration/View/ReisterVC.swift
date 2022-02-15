//
//  File.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/1/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import RxCocoa
import RxSwift
import SKActivityIndicatorView
class ReisterVC: UIViewController {
    
    @IBOutlet weak var signin: UIButton!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var IMAGVIEW: UIImageView!
    @IBOutlet weak var ImageBtn: UIButton!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var PhoneTxt: UITextField!
    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var NameTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let registerViewModel = RegisterViewModel()
    let disposeBag = DisposeBag()
    
    var img:UIImageView?
    var imgBtn:UIButton?
    var SelectedAssets = [PHAsset]()
    var thumbnail = UIImage()
    var PhotoArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupcomponents()
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeToResponse()
        subscribeToLoginButton()
    }
    func setupcomponents(){
        IMAGVIEW?.layer.cornerRadius = (IMAGVIEW?.frame.width)!/3
        IMAGVIEW?.layer.cornerRadius = (IMAGVIEW?.frame.height)!/3

        IMAGVIEW?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        signin?.layer.cornerRadius = 15
        signin?.layer.masksToBounds = true
        signup?.layer.cornerRadius = 15
        signup?.layer.masksToBounds = true
        loginButton?.layer.cornerRadius = 15
        loginButton?.layer.masksToBounds = true
        subview?.layer.cornerRadius = 20
        subview?.layer.masksToBounds = true
        subview?.layer.shadowRadius = 8.0
        subview?.layer.shadowColor = UIColor.black.cgColor
        
    }
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func selectImageTapped(_ sender: Any) {
        self.img = IMAGVIEW
        self.imgBtn = ImageBtn
        
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 10
        vc.takePhotos = true
        //  vc.sourceType = .camera
        //display picture gallery
        self.bs_presentImagePickerController(vc, animated: true,
                                             select: { (asset: PHAsset) -> Void in
                                                
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets
            for i in 0..<assets.count
            {
                self.SelectedAssets.append(assets[i])
                
            }
            
            self.convertAssetToImages()
            
        }, completion: nil)
        
        
    }
    func convertAssetToImages() -> Void {
        if SelectedAssets.count != 0{
            
            
            for i in 0..<SelectedAssets.count{
                
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                
                
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    self.thumbnail = result!
                    
                })
                
                let data = thumbnail.jpegData(compressionQuality: 0.7)
                let newImage = UIImage(data: data!)
                
                
                self.PhotoArray.append(newImage! as UIImage)
                
            }
            
            self.img?.animationImages = self.PhotoArray
            
            self.img?.animationDuration = 3.0
            self.img?.startAnimating()
            
        }
        
        
        print("complete photo array \(self.PhotoArray)")
    }
    func bindTextFieldsToViewModel() {
        EmailTxt?.rx.text.orEmpty.bind(to: registerViewModel.EmailBehavior).disposed(by: disposeBag)
        PasswordTxt?.rx.text.orEmpty.bind(to: registerViewModel.PasswordBehavior).disposed(by: disposeBag)
        PhoneTxt?.rx.text.orEmpty.bind(to: registerViewModel.PhoneBehavior).disposed(by: disposeBag)
        NameTxt?.rx.text.orEmpty.bind(to: registerViewModel.NameBehavior).disposed(by: disposeBag)
        
    }
    func subscribeToLoading() {
        registerViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                SKActivityIndicator.show()
                
            } else {
            SKActivityIndicator.dismiss()
                
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        registerViewModel.registerModelObservable.subscribe(onNext: {
            if $0.status == true {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeVC
                self.present(vc, animated: true, completion: nil)
                self.showToast(message: "regesration done successfully")
                UserDefaults.standard.set($0.data?.token, forKey: "TOKEN")
                UserDefaults.standard.set($0.data?.id, forKey: "IDUSER")
                UserDefaults.standard.set($0.data?.name, forKey: "NAMEUSER")
                UserDefaults.standard.set($0.data?.phone, forKey: "NAMEPHONE")
                UserDefaults.standard.set($0.data?.email, forKey: "NAMEEMAIL")
                UserDefaults.standard.synchronize()
                self.EmailTxt.text = ""
                self.PasswordTxt.text = ""
                self.PhoneTxt.text = ""
                self.NameTxt.text = ""
                self.IMAGVIEW.isHidden = true
            }
            else {
                self.showToast(message: $0.message!)
                
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToLoginButton() {
        loginButton?.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.registerViewModel.Register()
            }).disposed(by: disposeBag)
    }
    
}
