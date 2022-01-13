//
//  KPNetworkManager.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import UIKit
import SwiftyJSON
import Alamofire

class Connectivity
{
    class func isConnectedToInternet() ->Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}



class KPNetworkManager: NSObject{
    
    class var shared : KPNetworkManager {
        struct Static{
            static let instance = KPNetworkManager()
        }
        return Static.instance
    }
    fileprivate override init(){}
    
    
    //MARK: API Post Request Method
    
    func webserviceCallWithModel<T: Codable>(type: T.Type,
                                             strUrl : String,
                                             method : HTTPMethod,
                                             params : [String : Any]? = [:],
                                            
                                             headerParam : [String : String]? = nil,
                                             
                                             success: @escaping (_ value: (T)) -> Void,
                                             failure: @escaping (_ error: String) -> Void){
        
        
        if !Connectivity.isConnectedToInternet(){
            
            return
        }
    
    
        request(strUrl, method: method, parameters: params, headers: nil).responseJSON { (dataResponse) in
            
           
            
            switch dataResponse.result{
            case .success(let JSON):
                print("Response : \(JSON)")
                
                let json = dataResponse.data
                do{
                    let decoder = JSONDecoder()
//
                    if let j = JSON as? [String:Any] {
                       
                            if let temp =  j as? [String:Any] {
                                if temp.count > 0 {
                                    let jsonData = try JSONSerialization.data(withJSONObject: temp, options: [])
                                    let modelObj = try decoder.decode(type, from: jsonData)
                                    success(modelObj)
                                } else {
                                    let jsonData = try JSONSerialization.data(withJSONObject: temp, options: [])
                                    let modelObj = try decoder.decode(type, from: jsonData)
                                    success(modelObj)
                                }
                            } else {
//
                            }
                        
                    }else{
                        //Data not found
                        failure("No data Found!")
                    }
              
                }catch let error{
                    print(error)
                    failure(error.localizedDescription)

                }
                
            case .failure(let error):
                print(error.localizedDescription)
                failure(error.localizedDescription)

            }
        }
    }
    
    //MARK: API Get Request Method
    func webserviceCallGetWithModel<T: Codable>(type: T.Type,
                                             strUrl : String,
                                             method : HTTPMethod,
                                             token : String,
                                             params : [String : Any]? = [:],
                                             headerParam : [String : String]? = nil,
                                            
                                             success: @escaping (_ value: (T)) -> Void,
                                             failure: @escaping (_ error: String) -> Void){
        
        
        if !Connectivity.isConnectedToInternet(){
            
            return
        }
        
        
        
        var defaultParams : [String:Any] = [:]
        
        var header : [String : String] = [
            "Authorization"  : "Bearer \(token)",
        ]
        
        
        if let aParam = params{
            aParam.forEach { (k,v) in defaultParams[k] = v }
        }
        
        if let prm = headerParam{
            prm.forEach { (k,v) in header[k] = v }
        }
        
        print("URL: \(strUrl)")
        print("Parameters: \(defaultParams)")
        print("headerParameters: \(header)")
        
       
        request(strUrl, method: method, parameters: defaultParams, headers: header).responseJSON { (dataResponse) in
            
           
            
            switch dataResponse.result{
            case .success(let JSON):
                print("Response : \(JSON)")
                
                let json = dataResponse.data
                do{
                    let decoder = JSONDecoder()
                 
                   
                    if let j = JSON as? [String:Any] {
                       
                            if let temp =  j as? [String:Any] {
                                if temp.count > 0 {
                                    let jsonData = try JSONSerialization.data(withJSONObject: temp, options: [])
                                    let modelObj = try decoder.decode(type, from: jsonData)
                                    success(modelObj)
                                } else {
                                    let jsonData = try JSONSerialization.data(withJSONObject: temp, options: [])
                                    let modelObj = try decoder.decode(type, from: jsonData)
                                    success(modelObj)
                                }
                            } else {
//
                            }
                        
                    }else{
                        //Data not found
                        failure("No data Found!")
                    }
               
                }catch let error{
                    print(error)
                    failure(error.localizedDescription)

                }
                
            case .failure(let error):
                print(error.localizedDescription)
                failure(error.localizedDescription)

            }
        }
    }
    
}
