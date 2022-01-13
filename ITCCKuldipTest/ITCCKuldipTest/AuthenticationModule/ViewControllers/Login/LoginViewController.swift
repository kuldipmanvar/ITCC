//
//  LoginViewController.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import UIKit
import SkyFloatingLabelTextField
import MBProgressHUD
class LoginViewController: UIViewController {
    //MARK: Golbal Varibale Declare
    var userLoginData: Login!
    var userProfileData: Login!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    var db:DBHelper = DBHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    //MARK: Button action
    @IBAction func loginButtonAction(_ sender: Any) {
        view.endEditing(true)
        if isValidate(){
            //Call Login Service
            self.LoginAPI()
        }
        
    }
    //MARK: Validation Messages
    private func isValidate() -> Bool{
        if (txtEmail.text?.isEmpty)!{
            txtEmail.errorMessage = constantTitle.PleaseenterEmail
            
        }else if !(txtEmail.text?.isValidEmail)!{
            txtEmail.errorMessage = constantTitle.Please_enter_valid_Email
            
        }else if (txtPassword.text?.isEmpty)!{
            txtEmail.errorMessage = constantTitle.Please_enter_Password
            
            
        }else{
            txtEmail.errorMessage = ""
            txtPassword.errorMessage = ""
            return true
        }
        return false
    }
    
    //MARK: API calling
    func LoginAPI(){
        
        var param : [String:Any] = [:]
        
        param[APIKeys.email] = "\(txtEmail.text!)"
        param[APIKeys.password] = "\(txtPassword.text!)"
        param[APIKeys.platform] = "iOS"
        param[APIKeys.os_version] = "iOS 14.3"
        param[APIKeys.application_version] = "V1"
        param[APIKeys.model] = "iPhone"
        param[APIKeys.type] = "Gmail"
        param[APIKeys.uid] = UIDevice.current.identifierForVendor!.uuidString
        
        // Progress Bar Display
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        KPNetworkManager.shared.webserviceCallWithModel(type: Login.self, strUrl: WebAPI.login, method: .post, params: param,success: { (response) in
            MBProgressHUD.hide(for: self.view, animated: false)
            
            
            self.userLoginData = response
            
            guard (self.userLoginData.token) != nil else {
                print("Token is blank")
                return
            }
            self.registerAPI(token: self.userLoginData.token ?? "")
            
        }) { (ERROR) in
            
        }
    }
    func registerAPI(token:String)
    {
        
        let param : [String:Any] = [:]
        
        KPNetworkManager.shared.webserviceCallGetWithModel(type: Login.self, strUrl: WebAPI.profile, method: .get,token: token, params: param,success: { (response) in
            MBProgressHUD.hide(for: self.view, animated: false)
            
            
            self.userProfileData = response
            
            let data = self.userProfileData.item
            self.db.insert(id: 0, is_first_time: data?.is_first_time ?? 0, profile_pic: data?.profile_pic ?? "", type: data?.type ?? "", dob: data?.dob ?? "" , last_name: data?.last_name ?? "", user_type: data?.user_type ?? 0, email: data?.email ?? "", iD: data?.id ?? 0, gender: data?.gender ?? "", first_name: data?.first_name ?? "", role_name: data?.role_name ?? "")
            //
            let dataProfile = self.db.read()
//            print("dataProfile:-",dataProfile[0].email)
//            print("dataProfile:-",dataProfile[0].type)
//
            
        }) { (ERROR) in
            
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
