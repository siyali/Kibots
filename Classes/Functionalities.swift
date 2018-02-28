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
    var databaseHandleHolding: FIRDatabaseHandle?
    var databaseHandleProduction: FIRDatabaseHandle?
    var databaseHandleReceiving: FIRDatabaseHandle?
    static var myUser: User?
    static var currentSelection: SelectedSetup?
    static var fhList = [String]()
    static var holdingDict = [String: [String]]() // holdingDict[KitchenStation] = [fn1, fn2,...]
    static var productionDict = [String: [String]]()
    static var receivingDict = [String: [String]]() // receiving[KitchenStation] = [fn0, fn10,...]
    
    static var vendorDict = [String: Dictionary<String, [String]>]() //vendorDict[vendor] = Dictionary<KitchenStation, FoodItems>
    
    static var userExist = false
    func getFoodHandlerList(user: User){
        let ref = FIRDatabase.database().reference()
        databaseHandle = ref.child("Users").child(user.userID!).child("Food Handlers").observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                let handlerName = next.value as? String
//                if handlerName != nil{
                    if Functionalities.fhList.contains(handlerName!) == false{
                        Functionalities.fhList.append(handlerName!)
     
                    }
//                }
            }
        })
    }
    func getOperationDict(user: User){
        let ref = FIRDatabase.database().reference().child("Users").child(user.userID!).child("Operations")
        
        databaseHandleHolding = ref.child("Holding").observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                print(next.key)
                let stationName = next.value as! NSDictionary
//                print("station value")
//               // print(type(of: stationName))
//                print(stationName)
//                print(stationName.allKeys)
//                print(stationName.allValues)
                Functionalities.holdingDict[next.key] = stationName.allValues as? [String]
            }
    
        })
        
        databaseHandleProduction = ref.child("Production").observe(.value, with: { (snapshot) in
//            let snap = snapshot.value
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                
                let stationName = next.value as! NSDictionary
                Functionalities.productionDict[next.key] = stationName.allValues as? [String]
            }
            
        })
        databaseHandleReceiving = ref.child("Receiving").observe(.value, with: { (snapshot) in
            
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                
                let station = next.value as! NSDictionary
                //Functionalities.productionDict[next.key] = stationName.allValues as? [String]
                print(station)
                print("station name should be")
                print(next.key)
                
                for (key,value) in station{
                    print("inside iteration")
                    print(key)
                    print(value)
                    
//                    if (Functionalities.receivingDict[key as! String]?.contains(value as! String))! == false{
                        Functionalities.receivingDict[key as! String]?.append(value as! String)
                    print("receiving dict")
                    print(Functionalities.receivingDict)
//                    }
                }
                Functionalities.vendorDict[next.key] = Functionalities.receivingDict
                print("actual process")
                print(Functionalities.vendorDict)
            }
            
        })
        print("op Dictt")
        print(Functionalities.vendorDict)
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
