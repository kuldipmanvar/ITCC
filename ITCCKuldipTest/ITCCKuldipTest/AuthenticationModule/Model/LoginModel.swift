//
//  LoginModel.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 12/01/22.
//

import Foundation

struct Login : Codable {
    let item : Item?
    let status : Bool?
    let message : String?
    let token : String?

    enum CodingKeys: String, CodingKey {

        case item = "item"
        case status = "status"
        case message = "message"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        item = try values.decodeIfPresent(Item.self, forKey: .item)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }

}



struct Item : Codable {
    let id : Int?
    let is_first_time : Int?
    let dob : String?
    let first_name : String?
    let gender : String?
    let profile_pic : String?
    let email : String?
    let user_type : Int?
    let last_name : String?
    let type : String?
    let role_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case is_first_time = "is_first_time"
        case dob = "dob"
        case first_name = "first_name"
        case gender = "gender"
        case profile_pic = "profile_pic"
        case email = "email"
        case user_type = "user_type"
        case last_name = "last_name"
        case type = "type"
        case role_name = "role_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        is_first_time = try values.decodeIfPresent(Int.self, forKey: .is_first_time)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        role_name = try values.decodeIfPresent(String.self, forKey: .role_name)
    }

}
