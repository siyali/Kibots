//
//  DataAccessObjects.swift
//  Kibots
//
//  Created by Siya Li on 2/12/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataAccessObject {
    var databaseHandle: FIRDatabaseHandle?
    
    let ref = FIRDatabase.database().reference()
    
    func addUser(user: User){
        //self.ref.child("Users").child(user.userID!).setValue(["uid": user.userID])
        self.ref.child("Users").child(user.userID!).setValue(["email": user.email])
    }
}
