//
//  Items.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 13/01/22.
//

import Foundation

//MARK: Items Model
class items
{
    
    var is_first_time: String = ""
    var profile_pic: String = ""
    var type: String = ""
    var dob: String = ""
    var last_name: String = ""
    var user_type: Int = 0
    var email: String = ""
    var id: Int = 0
    var gender: String = ""
    var first_name: String = ""
    var role_name: String = ""
  
    
    init(is_first_time:String, profile_pic:String, type:String ,dob: String,last_name: String,user_type: Int,email: String,id: Int,gender: String,first_name: String,role_name: String)
    {
        self.is_first_time = is_first_time
        self.profile_pic = profile_pic
        self.type = type
        self.dob = dob
        self.last_name  = last_name
        self.user_type  = user_type
        self.email  = email
        self.id  = id
        self.gender  = gender
        self.first_name  = first_name
        self.role_name  = role_name
        
        
    }
    
}
