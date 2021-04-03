//
//  UserInfo.swift
//  UIPickerHW
//
//  Created by Иван on 3/31/21.
//

import Foundation

struct User {
    let name: String
    let password: String
    
    static func getUserData() -> User {
        User(name: "User", password: "Password")
    }
}
