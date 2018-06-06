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
    let dao = DataAccessObject()
    init(emailAdd: String, uid: String) {
        userID = uid
        email = emailAdd
    
    }
    
    func addUserProfile(){
        dao.addUser(user: self)
    }
    func addFoodHandlerProfile(fh: String){
        dao.addFoodHandler(user: self, foodHandler: fh)
    }
    func updateFoodHandlerProfile(fh: [String]){
        dao.updateFoodHandler(user: self, foodHandlers: fh)
        
    }
    func updateCorrectiveActionList(actions: [String]){
        dao.updateCorrectiveActions(user: self, correctiveActions: actions)
    }
    func addHoldingStation( station: String){
        dao.addHoldingStation(user: self, station: station)
    }
    func addHoldingFoodItem(station: String, fooditem: String){
        dao.addHoldingFoodItem(user: self, station: station, fooditem: fooditem)
    }
    func addHoldingItemMin(station: String, fooditem: String, min: Int){
        dao.addHoldingItemMin(user: self, station: station, fooditem: fooditem, min: min)
    }
    func addHoldingItemMax(station: String, fooditem: String, max: Int){
        dao.addHoldingItemMax(user: self, station: station, fooditem: fooditem, max: max)
    }
    func updateHoldingFoodItem(station: String, fooditem: [String]){
        dao.updateHoldingFoodItem(user: self, station: station, fooditems: fooditem)
    }
    func addProductionStation(station: String){
        dao.addProductionStation(user: self, station: station)
    }

    func addProductionFoodItem( station: String, fooditem: String){
        dao.addProductionFoodItem(user: self, station: station, fooditem: fooditem)
    }
    func addProductionItemMin(station: String, fooditem: String, min: Int){
        dao.addProductionItemMin(user: self, station: station, fooditem: fooditem, min: min)
    }
    func addProductionItemMax(station: String, fooditem: String, max: Int){
        dao.addProductionItemMax(user: self, station: station, fooditem: fooditem, max: max)
    }
    func updateProductionFoodItem( station: String, fooditem: [String]){
        dao.updateProductionFoodItem(user: self, station: station, fooditems: fooditem)
    }
    func addReceivingVendor( vendor: String){
        dao.addReceivingVendor(user: self, vendor: vendor)
    }
    func addReceivingStation(vendor: String, station: String){
        dao.addReceivingStation(user: self, vendor: vendor, station: station)
    }
    func addReceivingFoodItem(vendor: String, station: String, fooditem: String){
        dao.addReceivingFoodItem(user: self, vendor: vendor, station: station, fooditem: fooditem)
    }
    func addReceivingItemMin(vendor: String, station: String, fooditem: String, min: Int){
        dao.addReceivingItemMin(user: self, vendor: vendor, station: station, fooditem: fooditem, min: min)
    }
    func addReceivingItemMax(vendor: String, station: String, fooditem: String, max: Int){
        dao.addReceivingItemMax(user: self, vendor: vendor, station: station, fooditem: fooditem, max: max)
    }
    func updateMinMaxTemp(hpr: String, station: String, fooditem: String, min: Int, max: Int){
        if(hpr == "Holding") || (hpr == "Production") || (hpr == "Receiving"){
    dao.updateMinMaxTemp(hpr: hpr, user: self, station: station, fooditem: fooditem, min:min, max: max)
        }
        
    }
    func updateHoldingWithMinMax(station: String, foodItems: [String], minmaxMap: [String: (Int,Int)]){
        dao.updateHoldingWithMinMax(user: self, station: station, foodItems: foodItems, minmaxMap: minmaxMap)
        
    }
    func updateProductionWithMinMax(station: String, foodItems: [String], minmaxMap: [String: (Int,Int)]){
        dao.updateProductionWithMinMax(user: self, station: station, foodItems: foodItems, minmaxMap: minmaxMap)
        
    }
    func updateReceivingWithMinMax(vendor: String, station: String, foodItems: [String],minmaxMap:[String:(Int,Int)]) {
        dao.updateReceivingWithMinMax(user: self, vendor: vendor, station: station, foodItems: foodItems, minmaxMap: minmaxMap)
    }
    func userExist(user:User) -> Bool {
        let ref = FIRDatabase.database().reference()
        

        ref.observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
            if snapshot.hasChild(user.userID!){
                Functionalities.userExist = true
            }


        
        })

        return Functionalities.userExist
    }
}
