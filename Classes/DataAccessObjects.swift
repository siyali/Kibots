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
//        self.ref.child("Users").child(user.userID!).setValue(["id": user.userID])
//        self.ref.child("Users").child(user.email!).setValue(["email": user.email])
//        self.ref.child("Users").child(user.email!).setValue(["id": user.userID])
    }
    func addFoodHandler(user: User, foodHandler: String){
//        self.ref.child("Users").child(user.userID!).child("Food Handlers").child(foodHandler).setValue(["Name":foodHandler])
        self.ref.child("Users").child(user.userID!).child("Food Handlers").child(foodHandler).setValue(foodHandler)

    }
    func addHoldingStation(user: User, station: String){
        self.ref.child("Users").child(user.userID!).child("Operations").child("Holding").child(station).setValue(station)
    }
    func addHoldingFoodItem(user: User, station: String, fooditem: String){
        self.ref.child("Users").child(user.userID!).child("Operations").child("Holding").child(station).child(fooditem).setValue(fooditem)
    }
    func addProductionStation(user: User, station: String){
        self.ref.child("Users").child(user.userID!).child("Operations").child("Production").child(station).setValue(station)
    }
    func addProductionFoodItem(user: User, station: String, fooditem: String){
        self.ref.child("Users").child(user.userID!).child("Operations").child("Production").child(station).child(fooditem).setValue(fooditem)
    }
    func addReceivingVendor(user: User, vendor: String){
        self.ref.child("Users").child(user.userID!).child("Operations").child("Receiving").child(vendor).setValue(vendor)
    }
    func addReceivingStation(user: User, vendor: String, station: String){
        self.ref.child("Users").child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).setValue(station)
    }
    func addReceivingFoodItem(user: User, vendor: String, station: String, fooditem: String){
        self.ref.child("Users").child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).child(fooditem).setValue(fooditem)
    }
    

}
