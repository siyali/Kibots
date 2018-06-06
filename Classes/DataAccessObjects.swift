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
        self.ref.child(user.userID!).setValue(["Email": user.email])
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
    func updateCorrectiveActions(user:User, correctiveActions: [String]) {
        self.ref.child(user.userID!).child("Corrective Actions").setValue(correctiveActions)
    }
    func addHoldingStation(user: User, station: String){
        self.ref.child(user.userID!).child("Operations").child("Holding").child(station).setValue(station)
        //self.ref.child("Users").child(user.userID!).child("Operations").child("Holding").child(station).setValue(station)
    }
    
    func addHoldingItemMin(user: User, station: String, fooditem: String, min: Int){
        self.ref.child(user.userID!).child("Operations").child("Holding").child(station).child(fooditem).child("Min").setValue(min)
    }
    func addHoldingItemMax(user: User, station: String, fooditem: String, max: Int){
        self.ref.child(user.userID!).child("Operations").child("Holding").child(station).child(fooditem).child("Max").setValue(max)
    }
    func addProductionItemMin(user: User, station: String, fooditem: String, min: Int){
        self.ref.child(user.userID!).child("Operations").child("Production").child(station).child(fooditem).child("Min").setValue(min)
    }
    func addProductionItemMax(user: User, station: String, fooditem: String, max: Int){
        self.ref.child(user.userID!).child("Operations").child("Production").child(station).child(fooditem).child("Max").setValue(max)
    }
    func addReceivingItemMin(user: User, vendor: String, station: String, fooditem: String, min: Int){
        self.ref.child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).child(fooditem).child("Min").setValue(min)
        //self.ref.child("Users").child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).child(fooditem).setValue(fooditem)
    }
    func addReceivingItemMax(user: User, vendor: String, station: String, fooditem: String, max: Int){
        self.ref.child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).child(fooditem).child("Max").setValue(max)
        //self.ref.child("Users").child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).child(fooditem).setValue(fooditem)
    }
    func updateHoldingFoodItem(user: User, station: String, fooditems: [String]){
        var local_hold = [String: String]()
        for item in fooditems{
            local_hold[item] = item
            //addHoldingFoodItem(user: user, station: station, fooditem: item)
        }
        
        
       self.ref.child(user.userID!).child("Operations").child("Holding").child(station).setValue(local_hold)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Holding").child(station).setValue(fooditems)
    }
    func updateProductionFoodItem(user: User, station: String, fooditems: [String]){
        var local_hold = [String: String]()
        for item in fooditems{
            local_hold[item] = item
        }
        self.ref.child(user.userID!).child("Operations").child("Production").child(station).setValue(local_hold)
        // self.ref.child("Users").child(user.userID!).child("Operations").child("Production").child(station).setValue(fooditems)
    }
    func updateReceivingFoodItem(user: User, vendor: String, station: String, fooditems: [String]){
        var local_hold = [String: String]()
        for item in fooditems{
            local_hold[item] = item
        }
        self.ref.child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).setValue(local_hold)

    }
    func updateMinMaxTemp(hpr: String,user: User, station: String, fooditem: String, min: Int, max: Int){
        self.ref.child(user.userID!).child("Operations").child(hpr).child(station).child(fooditem).child("Min").setValue(min)
        self.ref.child(user.userID!).child("Operations").child(hpr).child(station).child(fooditem).child("Max").setValue(max)

    }
    func updateHoldingWithMinMax(user: User, station: String, foodItems: [String], minmaxMap: [String: (Int,Int)]){
        updateHoldingFoodItem(user: user, station: station, fooditems: foodItems)
        
        for food in foodItems{
            
            
            guard let local_tuple:(Int,Int) = minmaxMap[food] else{
                continue
            }
            guard let food_array:[String:Int] = ["Min":local_tuple.0,"Max":local_tuple.1] else {
                continue
            }
            self.ref.child(user.userID!).child("Operations").child("Holding").child(station).child(food).setValue(food_array)
            
        }
    }
    func updateProductionWithMinMax(user: User, station: String, foodItems: [String], minmaxMap: [String: (Int,Int)]){
        updateProductionFoodItem(user: user, station: station, fooditems: foodItems)
        print("INSIDE minmax Map \(minmaxMap)")
        print("foodItems \(foodItems)")
        for food in foodItems{
            
            print("food \(food)")
            guard let local_tuple:(Int,Int) = minmaxMap[food] else{
                continue
            }
            guard let food_array:[String:Int] = ["Min":local_tuple.0,"Max":local_tuple.1] else {
                continue
            }
            print("food_array \(food_array)")
            self.ref.child(user.userID!).child("Operations").child("Production").child(station).child(food).setValue(food_array)
            
        }
    }
    func updateReceivingWithMinMax(user: User, vendor: String, station: String, foodItems: [String], minmaxMap: [String: (Int,Int)]){
        updateReceivingFoodItem(user: user, vendor: vendor, station: station, fooditems: foodItems)
        print("INSIDE minmax Map \(minmaxMap)")
        print("foodItems \(foodItems)")
        for food in foodItems{
            
            print("food \(food)")
            guard let local_tuple:(Int,Int) = minmaxMap[food] else{
                continue
            }
            guard let food_array:[String:Int] = ["Min":local_tuple.0,"Max":local_tuple.1] else {
                continue
            }
            print("food_array \(food_array)")
            self.ref.child(user.userID!).child("Operations").child("Receiving").child(vendor).child(station).child(food).setValue(food_array)
            
        }
    }
    func addProductionStation(user: User, station: String){
        self.ref.child(user.userID!).child("Operations").child("Production").child(station).setValue(station)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Production").child(station).setValue(station)
    }
    func addHoldingFoodItem(user: User, station: String, fooditem: String){
        self.ref.child(user.userID!).child("Operations").child("Holding").child(station).child(fooditem).setValue(fooditem)
    }
    func addProductionFoodItem(user: User, station: String, fooditem: String){
        self.ref.child(user.userID!).child("Operations").child("Production").child(station).child(fooditem).setValue(fooditem)
       // self.ref.child("Users").child(user.userID!).child("Operations").child("Production").child(station).child(fooditem).setValue(fooditem)
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
