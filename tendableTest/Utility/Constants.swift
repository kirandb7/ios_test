//
//  Constants.swift
//  FoodOps
//
//  Created by Kiran Babu Davis on 07/06/23.
//

import Foundation

struct APIConstant {
    let BASE_URL  = ""
    struct ErrorMessage {
        let SERVER_ERROR = "Server error"
        let INVALID_URL  = "Invalid Url"
    }
}

struct Constant {
    struct Keychain{
        let TOKEN = "token"
        let REFRESH_TOKEN = "refreshToken"
    }
    struct Common {
        let empty = ""
        let email = "Email"
        let password = "Password"
    }
}
