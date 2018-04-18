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
    func addHoldingStation( station: String){
        dao.addHoldingStation(user: self, station: station)
    }
    func addHoldingFoodItem(station: String, fooditem: String){
        dao.addHoldingFoodItem(user: self, station: station, fooditem: fooditem)
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
    func updateMinMaxTemp(hpr: String, station: String, fooditem: String, min: Int, max: Int){
        if(hpr == "Holding") || (hpr == "Production") || (hpr == "Receiving"){
            dao.updateMinMaxTemp(hpr: hpr, user: self, station: station, fooditem: fooditem, min: min, max:max)
        }
        
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
