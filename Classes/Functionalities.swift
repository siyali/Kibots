//
//  Functionalities.swift
//  Kibots
//
//  Created by Siya Li on 2/12/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class Functionalities{
    
    var databaseHandle: FIRDatabaseHandle?
    
    static var myUser: User?
    static var currentSelection: SelectedSetup?
    static var fhList = [String]()
    static var userExist = false
    func getFoodHandlerList(user: User){
        let ref = FIRDatabase.database().reference()
        databaseHandle = ref.child("Users").child(user.userID!).child("Food Handlers").observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                let handlerName = next.value as? String
                if Functionalities.fhList.contains(handlerName!) == false{
                    Functionalities.fhList.append(handlerName!)
 
                }
            }
        })
    }
//    func viewFoodHandlers(user: User) -> [String]{
//        var listFH:[String] = []
//        let allFH = ref.child("Users").child(user.userID!).child("Food Handlers")
//        allFH.observeSingleEvent(of: .value) { (snapshot) in
//            for child in snapshot.children{
//                let snap = child as! FIRDataSnapshot
//                let foodHanderName = snap.value as! String

//                listFH.append(foodHanderName)
//            }
//        }

//    }
}
