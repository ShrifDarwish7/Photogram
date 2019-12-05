//
//  User.swift
//  InstagramClone
//
//  Created by Sherif Darwish on 11/28/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation

class User {
    var uid : String?
    var username : String?
    var email : String?
    var photo : String?
    
    init(uid : String , username : String , email : String , photo : String) {
        self.uid = uid
        self.username = username
        self.email = email
        self.photo = photo
    }
}
