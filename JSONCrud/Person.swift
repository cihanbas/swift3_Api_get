//
//  Person.swift
//  JSONCrud
//
//  Created by cihanbas on 2.04.2020.
//  Copyright © 2020 cihanbas. All rights reserved.
//

import Foundation
import UIKit
class Person {
    
    var name :String
    var image : UIImage
    var email : String
    var address : String
    var dob : String
    var phone : String
    init(_name:String, _image:UIImage, _email: String, _address: String, _dob: String, _phone:String) {
        self.name = _name
        self.address = _address
        self.dob = _dob
        self.email = _email
        self.image = _image
        self.phone = _phone
        
    }
}
