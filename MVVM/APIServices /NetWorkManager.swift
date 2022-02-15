//
//  File.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/1/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//


import Foundation
import Alamofire
class NetWorkManager {
    static let instance = NetWorkManager()
    func API<T: Codable>( userImage: Data? = nil, method: HTTPMethod, url: String, parameters:[String:Any]? = nil, header: [String:String]?  = nil, completion: @escaping (_ error: Error?, _ status: Bool?, _ response: T?)->Void) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.methodDependent, headers: header)
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    completion(error,nil,nil)
                case .success(_):
                    if let dict = res.result.value as? Dictionary<String, Any>{
                        print(res.result)
                        guard let status = dict["status"] as? Bool else{return}
                        do{
                            guard let data = res.data else { return }
                            let response = try JSONDecoder().decode(T.self, from: data)
                            completion(nil,status,response)
                        }catch let err{
                            print("Error In Decode Data \(err.localizedDescription)")
                            completion(err,false,nil)
                        }
                    }
                    else{
                        completion(nil,false,nil)
                    }
                }
        }
        
    }
    func getproduct(method: HTTPMethod, url: String,complition: @ escaping(ProductModel?,Error?) ->Void){
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else { return }

            switch response.result
            {
            case .failure(let error):
                print("failuuuuuuuur ",error)
             complition(nil,error)
            case .success(let valu):
              // print(valu)
               do{
                let response = try JSONDecoder().decode(ProductModel.self, from: data)
                //print("respoooooooooooooooooooonse\(response)")
                complition(response,nil)
               }catch let err{
                print("Error In Decode Data \(err.localizedDescription)")
                complition(nil,err)
                }
            }
            
            
        }
    }
}


