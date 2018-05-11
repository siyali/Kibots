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
    
    
    //Thermapen BLE
    public static let charUUID =     "45544942-4C55-4554-4845-524DB87AD701"
    public static let serviceUUID =  "45544942-4C55-4554-4845-524DB87AD700"
    
    //Test BLE
    // public static let charUUID =     "9AB68A9B-10BB-4D99-B232-7EB23B304E70"
    //public static let serviceUUID =  "42320B6A-21CB-4CC1-AFDB-5EE872A600AC"
    
    
    //MQTT Configuration
    public  static let mqttHost = "34.216.110.205"
    
    public  static let mqttPort = 1883
    
    public  static let mqttTopic = "probe"
    
    
    
    
    var databaseHandle: FIRDatabaseHandle?
    var databaseHandleHolding: FIRDatabaseHandle?
    var databaseHandleProduction: FIRDatabaseHandle?
    var databaseHandleReceiving: FIRDatabaseHandle?
    static var myUser: User?
    static var currentSelection: SelectedSetup?
    static var fhList = [String]()
    static var holdingStations = [String]()
    static var productionStations = [String]()
    static var vendorList = [String]()
    static var vendorKitchens = [String]()
    static var vendorKitchenFoodList = [String]()
    static var holdingDict = [String: [String]]() // holdingDict[KitchenStation] = [fn1, fn2,...]
    static var holdingItems = [String]()
    static var productionDict = [String: [String]]()
    static var productionItems = [String]()
   // static var receivingDict = [String: [String]]() // receiving[KitchenStation] = [fn0, fn10,...]
    
    static var vendorDict = [String: Dictionary<String, [String]>]() //vendorDict[vendor] = Dictionary<KitchenStation, FoodItems>
    static var tappedOperation: String?
    static var tappedKitchenHP: String?
    static var tappedVendor: String?
    static var tappedKitchenR: String?
    
    static var tt_fh_selected: String?
    static var tt_operation_selected: String?
    static var tt_vendor_selected: String?
    static var tt_station_selected: String? // the station selected at "take temp"
    static var tt_fooditem_selected: String?
    static var current_min: String?
    static var current_max: String?
    
    static var minMaxMap = [String: (Int, Int)]()
    
    static var userExist = false
    // the followins vars are used for buttons in tt
    static var hideOPE = true
    static var hideKS = true
    static var hideFood = true
    static var enableRecord = false
    
    func getFoodHandlerList() /*-> [String]*/{
        let user = Functionalities.myUser!
        let ref = FIRDatabase.database().reference()
        
        
        databaseHandle = ref.child(user.userID!).child("Food Handlers").observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                let handlerName = next.value as! String
                print(handlerName)
                
                if Functionalities.fhList.contains(handlerName) == false{
                    Functionalities.fhList.append(handlerName)
                }
            }
        })
//        ref.child("Users").child(user.userID!).child("Food Handlers").observeSingleEvent(of: .value, with: { (snapshot) in
//            for child in snapshot.children {
//                let snap = child as! FIRDataSnapshot
//                let key = snap.key
//                let value = snap.value
//                tmp_fhList.append(value as! String)
//                print("key = \(key)  value = \(value!)")
//            }
//        })

    }
    func getHoldingStations() /*-> [String]*/ {
  
        let user = Functionalities.myUser
        let ref = FIRDatabase.database().reference().child((user?.userID)!).child("Operations")
        databaseHandleHolding = ref.child("Holding").observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {

                if Functionalities.holdingStations.contains(next.key) == false{
                    Functionalities.holdingStations.append(next.key)
                }
            }
        })
 
    }
//    func getHoldingFoodList() -> [String]{
//        var foodlist = [String]()
//        var tmp_Dict = getHoldingDict()
//        //        getOperationDict(user: Functionalities.myUser!)
//        if Functionalities.tappedVendor != nil {
//            guard (tmp_vendorDict[Functionalities.tappedVendor!]) != nil else{
//                return receivedAllKitchen
//            }
//            for (key,_) in tmp_vendorDict[Functionalities.tappedVendor!]!{
//                receivedAllKitchen.append(key)
//            }
//        }
//        return receivedAllKitchen
//    }
    func getProductionStations() /*-> [String] */{
        
        let user = Functionalities.myUser
        let ref = FIRDatabase.database().reference().child((user?.userID)!).child("Operations")
        databaseHandleHolding = ref.child("Production").observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {

                if Functionalities.productionStations.contains(next.key) == false{
                    Functionalities.productionStations.append(next.key)
                }
            }
        })
    }
    func getVendorList() /*-> [String]*/ {
        let user = Functionalities.myUser
        let ref = FIRDatabase.database().reference().child((user?.userID!)!).child("Operations")
        
        databaseHandleReceiving = ref.child("Receiving").observe(.value, with: { (snapshot) in
            
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                print("vendor name")
                print(next.key)
                if Functionalities.vendorList.contains(next.key) == false{
                    Functionalities.vendorList.append(next.key)
                }
            }
            
        })
 
    }

    func getVendorKitchens() /*-> [String]*/{
//        var receivedAllKitchen = [String]()
        var tmp_vendorDict = Functionalities.vendorDict
//        getOperationDict(user: Functionalities.myUser!)
        if Functionalities.tappedVendor != nil {
            guard (tmp_vendorDict[Functionalities.tappedVendor!]) != nil else{
                Functionalities.vendorKitchens = []
                return
            }
            for (key,_) in tmp_vendorDict[Functionalities.tappedVendor!]!{
                if Functionalities.vendorKitchens.contains(key) == false{
                    Functionalities.vendorKitchens.append(key)
                }
            }
        }
        
    }
    func getVendorKitchenFoodList() /*-> [String]*/{
   //     var receivedAllFood = [String]()
        Functionalities().getVendorDict()
        Functionalities().getVendorKitchens()
        
        var tmp_vendorDict = Functionalities.vendorDict
        if Functionalities.tappedVendor != nil{
            let tmp_kitchenDict = tmp_vendorDict[Functionalities.tappedVendor!]
            if Functionalities.tappedKitchenR != nil {
                guard (tmp_kitchenDict![Functionalities.tappedKitchenR!]) != nil else{
                    return
                }
                for key in tmp_kitchenDict![Functionalities.tappedKitchenR!]!{
                    if Functionalities.vendorKitchenFoodList.contains(key) == false{
                        Functionalities.vendorKitchenFoodList.append(key)
                    }
                }
            }
        }
        
    }
/*
    func updateVendorDict(user: User){
        let ref = FIRDatabase.database().reference().child("Users").child(user.userID!).child("Operations")
        
        databaseHandleReceiving = ref.child("Receiving").observe(.value, with: { (snapshot) in
            
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                var receivingDict = [String: [String]]()
                
                guard let station = next.value as? NSDictionary else{
                    
                    print("guard entered")
                    print(next.value)
                    if Functionalities.vendorList.contains(next.value as! String) == false{
                        Functionalities.vendorList.append(next.value as! String)
                    }
                    continue
                }
                //Functionalities.productionDict[next.key] = stationName.allValues as? [String]
                print(station) // all stations
                print("station name should be")
                print(next.key)
                
                for (key,value) in station{
                    print("inside iteration")
                    print(key)
                    print(value)
                    var vArr:[String] = []
                    guard value is NSDictionary else{
                        receivingDict[key as! String] = []
                        continue
                    }
                    
                    for v in value as! NSDictionary{
                        print("food iname")
                        print(v.value)
                        vArr.append(v.value as! String)
                    }
                    //                    if (Functionalities.receivingDict[key as! String]?.contains(value as! String))! == false{
                    receivingDict[key as! String] = vArr
                    print("receiving dict")
                    print(receivingDict)
                    //                    }
                }
                Functionalities.vendorDict[next.key] = receivingDict
                print("actual process")
                print(Functionalities.vendorDict)
            }
            
        })
    }
*/
    func getHoldingDict()/* -> [String: [String]] */{
        
        let user = Functionalities.myUser
        let ref = FIRDatabase.database().reference().child((user?.userID)!).child("Operations")
        
        databaseHandleHolding = ref.child("Holding").observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                
                guard let stationName = next.value as? NSDictionary else{
                    Functionalities.holdingDict[next.key] = []
                    continue
                }
//                print("stationNameeeee:")
//                print(stationName)
//                print("stationALLVAL")
//                print(stationName.allValues)
                Functionalities.holdingDict[next.key] = stationName.allValues as? [String]
            }
            
            
    
        })
      
    }
    func getMinMaxMap(station: String) {
        let user = Functionalities.myUser
        let ref = FIRDatabase.database().reference().child((user?.userID)!).child("Operations").child(station)
        var min_val: String?
        var max_val: String?
        databaseHandle = ref.observe(.value, with: {(snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {

                guard let  map = next.value as? NSDictionary else{
                    Functionalities.minMaxMap = [:]
                    continue
                }
                print("allVALS")
                print(map.allValues)
                var mapp = map.allValues as? [String]
                print("maPPP")
                print(mapp)
                
            }
        })
    }
//    func getMinMaxMap(station: String,fooditem: String){
//        let user = Functionalities.myUser
//        let ref = FIRDatabase.database().reference().child((user?.userID)!).child("Operations").child(station).child(fooditem)
//        databaseHandle = ref.observe(.value, with: {(snapshot) in
//            let enumerator = snapshot.children
//            while let next = enumerator.nextObject() as? FIRDataSnapshot {
//                
//                guard let stationName = next.value as? NSDictionary else{
//                    Functionalities.holdingDict[next.key] = []
//                    continue
//                }
//                
//                Functionalities.holdingDict[next.key] = stationName.allValues as? [String]
//            }
//        })
//        
//    }
    func getHoldingItems(station: String){
        
        let user = Functionalities.myUser
        let ref = FIRDatabase.database().reference().child((user?.userID)!).child("Operations")
        
        databaseHandleHolding = ref.child("Holding").child(station).observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                if let food_name = next.value as? String {
                    if Functionalities.holdingItems.contains(food_name) == false{
                        Functionalities.holdingItems.append(food_name)
                    }
                }
                else{
                    
                    if Functionalities.holdingItems.contains(next.key as! String) == false{
                        Functionalities.holdingItems.append(next.key as! String)
                    }
                    let tuple = next.value as! [String:Int]
                    let minTemp = tuple["Min"]
                    let maxTemp = tuple["Max"]
                    
                    if(maxTemp != nil) {
                        if (minTemp != nil){
                            Functionalities.minMaxMap[next.key] = (minTemp, maxTemp) as! (Int, Int)
                        }
                        else{
                            Functionalities.minMaxMap[next.key]?.1 = maxTemp!
                        }
                    }else{
                        if (minTemp != nil){
                            Functionalities.minMaxMap[next.key]?.0 = minTemp!
                        }
                    }
                }
            }
    
            
            
            
        })
    }
    func getProductionItems(station: String){
        
        let user = Functionalities.myUser
        let ref = FIRDatabase.database().reference().child((user?.userID)!).child("Operations")
        
        databaseHandleHolding = ref.child("Production").child(station).observe(.value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                if Functionalities.productionItems.contains(next.value as! String) == false{
                    Functionalities.productionItems.append(next.value as! String)
                }
            }
            print("Production items")
            print(Functionalities.productionItems)
            
            
            
        })
    }
    func getProductionDict() /*-> [String: [String]]*/{
        let user = Functionalities.myUser
        
        let ref = FIRDatabase.database().reference().child((user?.userID!)!).child("Operations")
        databaseHandleProduction = ref.child("Production").observe(.value, with: { (snapshot) in
//            let snap = snapshot.value
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                
                guard let stationName = next.value as? NSDictionary else{
                    Functionalities.productionDict[next.key] = []
                    continue
                }
                Functionalities.productionDict[next.key] = stationName.allValues as? [String]
            }
            
        })
    
        
    }

    func getVendorDict() /*-> [String: Dictionary<String, [String]>]*/{
        let user = Functionalities.myUser
        let ref = FIRDatabase.database().reference().child((user?.userID!)!).child("Operations")
       
        
        
        databaseHandleReceiving = ref.child("Receiving").observe(.value, with: { (snapshot) in
            
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                var receivingDict = [String: [String]]()
                print("vendor name next.key")
                print(next.key)
                guard let vendor = next.value as? NSDictionary else{

//                    if Functionalities.vendorList.contains(next.value as! String) == false{
//                        Functionalities.vendorList.append(next.value as! String)
//                    }
                    continue
                }
                //Functionalities.productionDict[next.key] = stationName.allValues as? [String]
                print("all vendors")
                print(vendor) // all stations
//                print("station name should be")
//                print(station.key)
                
                for (key,value) in vendor{
                    print("inside one vendor iteration")
                    print("station name")
                    print(key)
                    print("dictionary of food items")
                    print(value)
                    var vArr:[String] = []
                    guard value is NSDictionary else{
                        receivingDict[key as! String] = []
                        print("gargard")
                        continue
                    }
                    
                    for v in value as! NSDictionary{
                        print("food iname")
                        print(v.value)
                        vArr.append(v.value as! String)
                    }
//                    if (Functionalities.receivingDict[key as! String]?.contains(value as! String))! == false{
                    receivingDict[key as! String] = vArr
                    print("receiving dict")
                    print(receivingDict)
//                    }
                }
                Functionalities.vendorDict[next.key] = receivingDict
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
