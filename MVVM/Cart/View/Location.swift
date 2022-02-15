//
//  Location.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/14/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class Location: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var mapview: MKMapView!
    var locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        floatingButton()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let currentLocation = locations.first else { return }
        currentCoordinate = currentLocation.coordinate
        mapview.userTrackingMode = .followWithHeading
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func buscket(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cart") as! CartVC
        self.present(vc, animated:true, completion: nil)
        
    }
    func floatingButton(){
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x:150, y: 700, width: 100, height: 100)
        btn.setTitle("Confirm", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 50
        btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.layer.borderWidth = 3.0
        //  btn.setBackgroundImage(self.image, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(goToLocation), for: .touchUpInside)
        
        view.addSubview(btn)
    }
    
    @objc  func goToLocation() {
     self .showToast(message: "Order has Confirmed Successfuly")
    }
    
   
}
