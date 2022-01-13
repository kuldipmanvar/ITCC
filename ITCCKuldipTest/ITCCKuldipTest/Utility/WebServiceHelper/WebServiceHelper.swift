//
//  WebServiceHelper.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import UIKit
import SwiftyJSON
import Alamofire

//Check Network Rechability
class Connectivity
{
    class func isConnectedToInternet() ->Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}

class WebServiceHelper: NSObject
{
    typealias SuccessHandler = (JSON) -> Void
    typealias FailureHandler = (Error) -> Void
    
    
    
    class func postWebServiceCall(_ strURL : String, params : [String : Any]?,headerPrm : String,method : HTTPMethod? = .get, success : @escaping SuccessHandler, failure : @escaping FailureHandler)
    {
        if Connectivity.isConnectedToInternet(){
           
            
            //header
            
            let credentialData = "\(headerPrm)".data(using: String.Encoding.utf8)!
            let base64Credentials = credentialData.base64EncodedString(options: [])
            let header : [String : String] = [
                "Authorization"  : "Bearer \(headerPrm)",
            ]
            
            //header[APIKeys.kAuthorization] = APIKeys.kAuthorizationValue
            
//            if let prm = headerPrm{
//                prm.forEach { (k,v) in header[k] = v }
//            }
            
            //Param
            var newParam : [String : Any] = [
                "deviceType" : "Ios"
                //APIKeys.token :  APIKeys.kTokenValue
            ]
            if let aParam = params{
                newParam.merge(dict: aParam)
            }
            
            print("REQUEST: ",strURL)
            print("\nHEADER: ",header)
            print("\nParameters: ",newParam ?? "")
            
            
            
            

           
            Alamofire.request(strURL, method: method!, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { (resObj) -> Void in
                
                print(resObj)
                
                if resObj.result.isSuccess
                {
                    let resJson = JSON(resObj.result.value!)
                    //print("RESPONSE: ",resJson)
                  
                    success(resJson)
                }
                
                if resObj.result.isFailure
                {
                    let error : Error = resObj.result.error!
                    print("ERROR: ",error.localizedDescription)
//                   
//                    if let topVC = UIApplication.topViewController(){
//                        topVC.showAlertWithCompletion(pTitle: "", pStrMessage: Localized(LocaleKey.kDefaultErrorMessage), completionBlock: nil)
//                    }
                    failure(error)
                }
            }
        }else{
            
            //Here Display Alert for No Internect
          /*  if let topVC = UIApplication.topViewController(){
                topVC.showAlertWithCompletion(pTitle: "", pStrMessage: Localized(LocaleKey.kDefaultNoInternetMessage), completionBlock: nil)
            }*/
        }
    }
    
    
    
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
