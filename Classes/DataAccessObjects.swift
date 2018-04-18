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
//        self.ref.child("Users").child(user.userID!).setValue(["email": user.email])
//        self.ref.child("Users").child(user.userID!).setValue(["id": user.userID])
        self.ref.child(user.userID!).setValue(["email": user.email])
//        self.ref.child("Users").child(user.email!).setValue(["id": user.userID])
    }
    func addFoodHandler(user: User, foodHandler: String){
//        self.ref.child("Users").child(user.userID!).child("Food Handlers").u
//        self.ref.child("Users").child(user.userID!).child("Food Handlers").child(foodHandler).setValue(foodHandler)
        self.ref.child(user.userID!).child("Food Handlers").child(foodHandler).setValue(foodHandler)

    }
    func updateFoodHandler(user: User, foodHandlers: [String]){
        //        self.ref.child("Users").child(user.userID!).child("Food Handlers").u
        self.ref.child(user.userID!).child("Food Handlers").setValue(foodHandlers)
//        self.ref.child("Users").child(user.userID!).child("Food Handlers").setValue(foodHandlers)
        
    }
    func addHoldingStation(user: User, station: String){
        self.ref.child(user.userID!).child("Operations").child("Holding").child(station).setValue(station)
        //self.ref.child("Users").child(user.userID!).child("Operations").child("Holding").child(station).setValue(station)
    }
    func addHoldingFoodItem(user: User, station: String, fooditem: String){
        self.ref.child(user.userID!).child("Operations").child("Holding").child(station).child(fooditem).setValue(fooditem)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Holding").child(station).child(fooditem).setValue(fooditem)
    }
    func updateHoldingFoodItem(user: User, station: String, fooditems: [String]){
        self.ref.child(user.userID!).child("Operations").child("Holding").child(station).setValue(fooditems)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Holding").child(station).setValue(fooditems)
    }
    func updateMinMaxTemp(hpr: String,user: User, station: String, fooditem: String, min: Int, max: Int){
        self.ref.child(user.userID!).child("Operations").child(hpr).child(station).child(fooditem).child("Min").setValue(min)
        self.ref.child(user.userID!).child("Operations").child(hpr).child(station).child(fooditem).child("Max").setValue(max)
    }
    func addProductionStation(user: User, station: String){
        self.ref.child(user.userID!).child("Operations").child("Production").child(station).setValue(station)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Production").child(station).setValue(station)
    }
    func addProductionFoodItem(user: User, station: String, fooditem: String){
        self.ref.child(user.userID!).child("Operations").child("Production").child(station).child(fooditem).setValue(fooditem)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Production").child(station).child(fooditem).setValue(fooditem)
    }
    func updateProductionFoodItem(user: User, station: String, fooditems: [String]){
        self.ref.child(user.userID!).child("Operations").child("Production").child(station).setValue(fooditems)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Production").child(station).setValue(fooditems)
    }
    func addReceivingVendor(user: User, vendor: String){
        self.ref.child(user.userID!).child("Operations").child("Receiving").child(vendor).setValue(vendor)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Receiving").child(vendor).setValue(vendor)
    }
    func addReceivingStation(user: User, vendor: String, station: String){
        self.ref.child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).setValue(station)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).setValue(station)
    }
    func addReceivingFoodItem(user: User, vendor: String, station: String, fooditem: String){
        self.ref.child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).child(fooditem).setValue(fooditem)
        //self.ref.child("Users").child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).child(fooditem).setValue(fooditem)
    }
    

}
