//
//  User.swift
//  Kibots
//
//  Created by Siya Li on 2/12/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
class User {
    var userID: String?
    var email: String?
    
    init(emailAdd: String, uid: String) {
        userID = uid
        email = emailAdd
    
    }
    
    func addUserProfile(){
        let dao = DataAccessObject()
        dao.addUser(user: self)
    }
    func userExist(user:User) -> Bool {
        let ref = FIRDatabase.database().reference()
        var returnVal = false
        ref.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            let users = snapshot.value as? NSDictionary
            let keys = users?.allKeys as! [NSString]
            for key in keys {
                if (user.userID == key as String) {
                    returnVal = true
                    
                }
            }
        })
        
        return returnVal
        
    }
}
