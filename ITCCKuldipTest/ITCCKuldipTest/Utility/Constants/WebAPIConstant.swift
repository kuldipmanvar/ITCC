//
//  WebAPIConstant.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import Foundation
import UIKit

struct WebAPI{
    static let BaseURL              = "http://ariel.itcc.net.au/api/v1/"
    static let login                = WebAPI.BaseURL + "auth/login"
    static let profile                = WebAPI.BaseURL + "auth/get-profile"
    
}
struct APIKeys {
    static let email                        = "email"
    static let username                     = "username"
    static let password                     = "password"
    static let platform                     = "platform"
    static let os_version                   = "os_version"
    static let application_version          = "application_version"
    static let model          = "model"
    static let type     = "type"
    static let uid     = "uid"
    
    
}
