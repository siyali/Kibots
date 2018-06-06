//
//  FoodResultVC.swift
//  Kibots
//
//  Created by Siya Li on 3/14/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit
import Moscapsule
import SwiftyBluetooth
import CoreBluetooth
class FoodResultVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var selectFHbtn: UIButton!
    
    @IBOutlet weak var selectOPEbtn: UIButton!
    
    @IBOutlet weak var selectKSbtn: UIButton!
    
    @IBOutlet weak var selectFoodbtn: UIButton!

    @IBOutlet weak var selectCorrAction: UIButton!
    
    
    
    @IBOutlet weak var presentTempView: UIView!
    
//    @IBOutlet var lblEmpname: UILabel!
//
//    @IBOutlet var lblopeType: UILabel!
//
//    @IBOutlet var lblstation: UILabel!
//
//    @IBOutlet var lblitem: UILabel!
    
    
    @IBOutlet var lblTemp: UILabel!
    
    
//    @IBOutlet var view1: UIView!
    
    
    @IBOutlet weak var btnRecord: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    
//    @IBOutlet var view2: UIView!
    
    @IBOutlet var btnDiscard: UIButton!
    
    @IBOutlet var btnTemp: UIButton!
    
    
    @IBOutlet weak var tempStack: UIStackView!
    var minTemp = 40
    var maxTemp = 140
    
    @IBOutlet weak var minMaxView: UIView!
    @IBOutlet weak var minLbl: UILabel!
    @IBOutlet weak var maxLbl: UILabel!
    
    @IBOutlet weak var actualTempLbl: UILabel!
    
    @IBOutlet weak var tempCutLbl: UILabel!
    @IBOutlet weak var safeLbl1: UILabel!
    
    @IBOutlet weak var safeLbl2: UILabel!
    
    @IBOutlet weak var unsafeLbl: UILabel!
    
    @IBOutlet var Indicator: UIActivityIndicatorView!
    
    var strStation = String()
    var strFood = String()
    var opeType = String()
    var opeTag = NSString()
    var strTemp = NSString()
    
    var empname = NSString()
    
    
    var mqttClient : MQTTClient?
    
    var peripheral : Peripheral? = nil
    
    
    var recordedTempHasBeenUpdated = false

    var currentTempIs : Float = 0.0;
    var recordedTempIs : Float = 0.0;
    var correctiveActionTaken : String  = ""
    var endTimeStamp : Date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 /*disabled for progress bar/stack view testing*/
        Functionalities().getFoodHandlerList()
        Functionalities().getHoldingStations()
        Functionalities().getHoldingDict()
        Functionalities().getProductionStations()
        Functionalities().getProductionDict()
        Functionalities().getVendorList()
        Functionalities().getCorrActions()
        
        if Functionalities.tt_station_selected != nil{
            if Functionalities.tt_operation_selected == "Holding" {
                Functionalities().getHoldingItems(station: Functionalities.tt_station_selected!)
            }else if Functionalities.tt_operation_selected == "Production"{
                Functionalities().getProductionItems(station: Functionalities.tt_station_selected!)
            }
        }
        Indicator.hidesWhenStopped = true
        // lblType.text = opeType
        
        btnRecord.isEnabled = Functionalities.enableRecord
        btnSubmit.isHidden = true
        
        selectCorrAction.isHidden = true
        selectCorrAction.isEnabled = false
        
        btnRecord.layer.cornerRadius = 5
//        btnTemp.layer.cornerRadius = 5
//        btnDiscard.layer.cornerRadius = 5
        
        if Functionalities.tt_fh_selected == nil{
            selectFHbtn.setTitle("Select Food Handler", for: .normal)
        } else{
            print("loading " + Functionalities.tt_fh_selected!)
            selectFHbtn.setTitle(Functionalities.tt_fh_selected,for: .normal)
        }
        
        if Functionalities.tt_corrAction_selected == nil{
            selectCorrAction.setTitle("Select Corrective Action", for: .normal)
        }else{
            selectCorrAction.setTitle( Functionalities.tt_corrAction_selected, for: .normal)
        }
        
        if Functionalities.tt_operation_selected == nil{
            selectOPEbtn.setTitle("Select Operation", for: .normal)
        }else{
            selectOPEbtn.setTitle(Functionalities.tt_operation_selected, for: .normal)
        }
        if Functionalities.tt_station_selected == nil{
            selectKSbtn.setTitle("Select Kitchen Station", for: .normal)
        } else{
            selectKSbtn.setTitle(Functionalities.tt_station_selected, for: .normal)
        }
        if Functionalities.tt_fooditem_selected == nil{
            selectFoodbtn.setTitle("Select Food Item", for: .normal)
        } else{
            selectFoodbtn.setTitle(Functionalities.tt_fooditem_selected, for: .normal)
        }
        
        if (Functionalities.hideOPE){
            selectOPEbtn.isHidden = true
        }
        if (Functionalities.hideKS){
            selectKSbtn.isHidden = true
        }
        if (Functionalities.hideFood){
            selectFoodbtn.isHidden = true
        }
        if (Functionalities.hideCA) {
            selectCorrAction.isHidden = true
        }
        
        
//        selectFHbtn.titleLabel?.text = NSString(format: "Employee:%@",empname) as String
//
//        selectOPEbtn.titleLabel?.text = NSString(format: "Operation:%@",opeType) as String
//        selectKSbtn.titleLabel?.text = NSString(format: "Station:%@",strStation) as String
//        selectFoodbtn.titleLabel?.text = NSString(format: "Food Item:%@",strFood) as String
        //        lblEmpname.text = NSString(format: "Employee:%@",empname) as String
        //        print("handler name \(lblEmpname)")
//        lblopeType.text = NSString(format: "Operation:%@",opeType) as String
//        lblstation.text = NSString(format: "Station:%@",strStation) as String
//        lblitem.text = NSString(format: "Food Item:%@",strFood) as String
        
        // lblTemp.text = NSString(format:"%@ F",strTemp) as String
        // lblTemp.text = "0\n°F"
        
        
// INITIALIZE PROGRESS BAR HERE
        
        if Functionalities.tt_fooditem_selected != nil{
            let tuple = Functionalities.minMaxMap[Functionalities.tt_fooditem_selected!]
            print("tuple \(tuple)")
            minTemp = (tuple?.0)!
            maxTemp = (tuple?.1)!
            var min_space = ""
            for _ in 1...minTemp{
                min_space += " "
            }
            let num_space_unsafe = maxTemp - minTemp
            var unsafe_space = ""
            for _ in 1...num_space_unsafe{
                unsafe_space += " "
            }
            let num_space_safe2 = 200 - maxTemp
            var safe2_space = ""
            for _ in 1...num_space_safe2{
                safe2_space += " "
            }
            safeLbl1.text = min_space
            safeLbl2.text = safe2_space
            unsafeLbl.text = unsafe_space
        } else{
            safeLbl1.text = "    "
            safeLbl2.text = "      "
            unsafeLbl.text = "          "
        }
        
        safeLbl1.textColor = safeLbl1.backgroundColor
        safeLbl2.textColor = safeLbl2.backgroundColor
        unsafeLbl.textColor = unsafeLbl.backgroundColor
       
        setBarTemperature(reading: 0.0)
  ///* Start of MINMAX INIT
        let screenSize = UIScreen.main.bounds
        let screenWidth = Float(screenSize.width)
        print("screenwidth \(screenWidth)")
        //    let screenHeight = screenSize.height
    
        let minStr = String(minTemp) + " ºF"
        self.minLbl.text = minStr
        
        let margin_constr = 20 as Float
        let minlbl_X = Float(minTemp)/200*(screenWidth-margin_constr*2) - Float(minLbl.intrinsicContentSize.width)/2 //+stack_margin_constr
        
        
        var cut_frm = minLbl.frame
     
        minLbl.frame.origin = CGPoint(x:CGFloat(minlbl_X), y:cut_frm.origin.y)

        let maxStr = String(maxTemp) + " ºF"
        self.maxLbl.text = maxStr
        
        let maxlbl_X = Float(maxTemp)/200*(screenWidth-margin_constr*2) - Float(maxLbl.intrinsicContentSize.width)/2 //+stack_margin_constr
        
        
        cut_frm = maxLbl.frame
        
        maxLbl.frame.origin = CGPoint(x:CGFloat(maxlbl_X), y:cut_frm.origin.y)


        
        
 //       end of MINMAX INIT*/

        
//        initObserver()
        
   
//        connectMosquito()
//        sendToMQTT(correctiveAction: "No Corrective Action")
        
/* TESTS that Worked
        moscapsule_init()
        let mqttConfig = MQTTConfig(clientId: "QWYsYX8VPOUNI", host: "34.216.110.205", port: 1883, keepAlive: 60)
        var notes = ""
        //        if let comment = txtComment.text
        //        {
        //            notes = comment
        //        }
        
        endTimeStamp = Date();
        print("checkMQTT")
        let package : [String:Any] =
            
            [
                "client_name":"Siya",
                "client_number":"001",
                "client_location":"32.8743015,-117.2431993",
                "email_id": "simon678910@hotmail.com",
                //"email_id":"victor.moreno@compass-usa.com",
                //"sensor_MAC":"00:1e:c0:50:6a:a2",
                "sensor_MAC":"2e:1e:c9:70:6a:a2",
                "inspection_time":getCurrentTimeStamp(),
                "day":getCurrentDay(),
                "duration":getDuration(),
                //                "operation":opeType, // Holding
                //                "employee":"\(empname)", // John
                //                "food_station":strStation,  // Lunch
                "operation": "PRODUCTION",
                "employee": "Victoria Morenzo",
                "food_station": "Lunch",
                //test above
                "supplier":"",  // None
                "food_name":"Guacamole",
                "temperature": 150.0,
                //                "food_name":strFood,    //Eggs
                //                "temperature":recordedTempIs,
                "corrective_action":"not required",
                "notes":notes
        ]
        
        print("data \(package)")
        
        let data = try! JSONSerialization.data(withJSONObject: package, options: .prettyPrinted)
        //let data: Data = NSKeyedArchiver.archivedData(withRootObject: package)
        
        

        mqttConfig.onConnectCallback = { returnCode in
            print("Return Code is \(returnCode.description)")

            if returnCode == ReturnCode.success {
                print("success connection MQTT")
            }
            else {
                print("failed connection MQTT")
            }
        }

        mqttClient = MQTT.newConnection(mqttConfig)
        print("package :: \(package) connection status :: \(String(describing: mqttClient?.isConnected))" )
        //self.mqttClient?.publish(data, topic: Functionalities.mqttTopic, qos: 2, retain: true)
        mqttClient?.publish(data, topic: "probe", qos: 2, retain: false)
        mqttClient?.subscribe("probe",qos: 2)
        
        print("haha")
        print( "\(mqttClient?.isConnected)")
        
        */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func initObserver()
    {
        
        peripheral = GlobalVariables.sharedManager.peripheral
        print("peripheral")
        print(peripheral)
        if (peripheral != nil) {
            print("peripheral set")
            NotificationCenter.default.addObserver(forName: Peripheral.PeripheralCharacteristicValueUpdate,  object: peripheral,   queue: nil) { (notification) in
                
                let charac = notification.userInfo!["characteristic"] as! CBCharacteristic
                let reading = self.swapUInt32Data(data: charac.value!)
                
                self.currentTempIs = reading;
                self.recordedTempIs = reading
                self.recordedTempHasBeenUpdated = true
            
                self.setBarTemperature(reading: reading)
                if reading < Float(self.maxTemp) && reading > Float(self.minTemp){
                    self.btnSubmit.setTitle("Take Corrective Action", for: .normal)
                    Functionalities.hideCA = false
                    self.selectCorrAction.isHidden = false
                    self.selectCorrAction.isEnabled = true
                }else{
                    self.btnSubmit.setTitle("Accept Food", for: .normal)
                    Functionalities.hideCA = true
                    self.selectCorrAction.isHidden = true
                    self.selectCorrAction.isEnabled = false
                }
                
            }
            
            // We can then set a characteristic's notification value to true and start receiving updates to that characteristic
            peripheral?.setNotifyValue(toEnabled: true, forCharacWithUUID: Functionalities.charUUID, ofServiceWithUUID: Functionalities.serviceUUID) { (isNotifying) in
                // If there were no errors, you will now receive Notifications when that characteristic value gets updated.
                
                
            }
            if(peripheral?.state != .connected){
                print("peripheral state not connected")
                doConnectToPeripheral(peripheral: peripheral!)
            }
            else{
                self.peripheral?.readValue(ofCharacWithUUID: Functionalities.charUUID, fromServiceWithUUID: Functionalities.serviceUUID) { result in
                    switch result {
                    case .success(let data):

                        
                        break;
                        
                    case .failure( _):
                        self.disconnectPeripheral(peripferal: self.peripheral!)
                        break;
                    }
                }
            }
            
        }
        else{
            print("pheripheral not set")
            showAlert();
            
        }
        
        
    }
    func setTemperature(reading : Float) -> Void {
        
        let Fstr = "°F"
        self.recordedTempIs = reading
        let mainstr = NSString(format:"%.1f\n%@",reading,Fstr) as NSString
        let range1 = mainstr.range(of: Fstr)
        let font1 = UIFont.boldSystemFont(ofSize: 68.0)
        let font2 = UIFont.boldSystemFont(ofSize: 28.0)
        
        let dic1 = [NSAttributedStringKey.font:font1]
        let dic2 = [NSAttributedStringKey.font:font2]
        
        let mutStr = NSMutableAttributedString(string: mainstr as String, attributes: dic1)
        mutStr.addAttributes(dic2, range: range1)
        
        self.lblTemp.attributedText = mutStr;
        
        
        
        
        
    }
    func setBarTemperature(reading: Float) -> Void{
        let screenSize = UIScreen.main.bounds
        let screenWidth = Float(screenSize.width)
       
    //    let screenHeight = screenSize.height
        
        
        self.recordedTempIs = reading
        let Fstr = " ºF"
        let tempStr = String(reading) + Fstr
        //let tempStr = String(format: "%.1f\n%@", reading, Fstr)
        self.actualTempLbl.text = tempStr
        
        let stack_margin_constr = 20 as Float
        let tempCut_X = reading/200*(screenWidth-stack_margin_constr*2)//+stack_margin_constr
        
        
        var cut_frame = tempCutLbl.frame
        cut_frame.origin.x = CGFloat(tempCut_X)
//        print("cut_frame x pos \(cut_frame.origin.x)")
//        tempCutLbl.frame = cut_frame
        tempCutLbl.frame.origin = CGPoint(x:CGFloat(tempCut_X), y:cut_frame.origin.y)

        
        var temp_frame = actualTempLbl.frame
        temp_frame.origin.x = CGFloat(tempCut_X - Float(actualTempLbl.intrinsicContentSize.width)/2)

        actualTempLbl.frame = temp_frame
        
        
    }
    
    func disconnectPeripheral(peripferal : Peripheral) -> Void {
        peripferal.disconnect { (result) in
        }
        
    }
    
    func doConnectToPeripheral(peripheral : Peripheral) -> Void {
        
        peripheral.connect(withTimeout: 36000 * 24) { result in
            switch result {
            case .success:
                
            break // You are now connected to the peripheral
            case .failure( _):
                print("failed to connect peripheral")
                self.showAlert();
                
                break // An error happened while connecting
            }
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showAlert() -> Void {
        let alert = UIAlertController(title: "Connection Status", message: "Device is not connected!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    func switchViewColor(reading : Float) -> Void {
        
        
        self.currentTempIs = reading;
        
        
        if (reading >= 40 && reading <= 140)
        {
            //self.lblFoodname.backgroundColor = UIColor.red
            self.lblTemp.backgroundColor = hexStringToUIColor(hex: "F95F62")
//            self.view1.isHidden = true
//            self.view2.isHidden = false
            
            
        }
        else
        {
            // self.lblFoodname.backgroundColor = UIColor.green
            self.lblTemp.backgroundColor = hexStringToUIColor(hex: "77D353")
//            self.view1.isHidden = false
//            self.view2.isHidden = true
        }
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func swapUInt32Data(data : Data) -> Float {
        var mdata = data // make a mutable copy
        let count = data.count / MemoryLayout<UInt32>.size
        mdata.withUnsafeMutableBytes { (i32ptr: UnsafeMutablePointer<UInt32>) in
            for i in 0..<count {
                i32ptr[i] =  i32ptr[i].byteSwapped
            }
        }
        
        
        return Float(bitPattern: UInt32(bigEndian: mdata.withUnsafeBytes { $0.pointee } )) * 1.8 + 32.3336
    }
    
    
    
    func connectMosquito()
    {
        
        // set MQTT Client Configuration
        //let mqttConfig = MQTTConfig(clientId: "kibots", host: "54.87.231.127", port: 1883, keepAlive: 60)
        moscapsule_init()
        let mqttConfig = MQTTConfig(clientId: "QWYsYX8VPOUNIQUE", host: Functionalities.mqttHost, port: Int32(Functionalities.mqttPort), keepAlive: 60)
        print("check connectMosquito")
        mqttConfig.onConnectCallback = { returnCode in
       //     print("Return Code is \(returnCode.description)")
            
            // publish and subscribe
            self.mqttClient?.subscribe(Functionalities.mqttTopic, qos: 2)
            
            
        }
        mqttConfig.onMessageCallback = { mqttMessage in
            //print("MQTT Message received: payload=\(String(describing: mqttMessage.payloadString))")
            //NSLog("MQTT Message received: payload=\(String(describing: mqttMessage.payloadString))")
            
            
        }
        
        mqttConfig.onPublishCallback = { messageId in
            print("published (mid=\(messageId))")
            
            
            
            let alert = UIAlertController(title: "Transaction Recorded", message:"Food Temperature: \(NSString(format:"%.1f °F",self.recordedTempIs) as NSString) \nCorrective Action: \(self.correctiveActionTaken) ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: self.myHandler))
            
            self.present(alert, animated: true)
            
            
            // disconnect
            self.mqttClient?.disconnect()
            
            
            DispatchQueue.main.async {
                
                self.Indicator.stopAnimating()
                self.Indicator.isHidden = true
                
            }
            
        }
        
        // create new MQTT Connection
        mqttClient = MQTT.newConnection(mqttConfig)
        print("created connection MQTT")
 
        
    }
    
    func myHandler(alert: UIAlertAction!) {
        
        self.mqttClient?.unsubscribe(Functionalities.mqttTopic)
        self.mqttClient?.disconnect()
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        
    }
    
    func getCurrentTimeStamp() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = formatter.string(from: endTimeStamp)
        
        return result;
    }
    
    
    func getDuration() -> String {
        
        
        //  let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        
        //let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: endTimeStamp , to: GlobalVariables.sharedManager.startTimeStamp);
        
        let elapsed = endTimeStamp.timeIntervalSince(GlobalVariables.sharedManager.startTimeStamp)
        
        let y = String(format: "%.1f", elapsed)
        
        print("duration \(y)")
        
        
        
        return y
        
        
    }
    
    
    
    func getCurrentDay() -> String {
        
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Satudrday,"
        ]
        
        let day =  Calendar.current.component(.weekday, from: Date())
        
        return weekdays[day - 1];
    }
    func sendToMQTT(correctiveAction : String) -> Void {
        
  /*
        moscapsule_init()
        let mqttConfig = MQTTConfig(clientId: "QWYsYX8VPOUNIQUE", host: "34.216.110.205", port: 1883, keepAlive: 60)
        
       
        
        mqttConfig.onConnectCallback = { returnCode in
            print("Return Code is \(returnCode.description)")
            
            if returnCode == ReturnCode.success {
                print("success connection MQTT")
            }
            else {
                print("failed connection MQTT")
            }
            
            // publish and subscribe
            self.mqttClient?.subscribe(Functionalities.mqttTopic, qos: 2)
            
            
        }
        let mqttClient = MQTT.newConnection(mqttConfig)
        print("check connectMosquito")
        */
        
        // the above is temporarily taking place of connectMosquito
        
        correctiveActionTaken = correctiveAction
        self.recordedTempIs = self.currentTempIs
        print("recorded TEMP \(self.recordedTempIs)")

        
//        if let comment = txtComment.text
//        {
//            notes = comment
//        }
        
        endTimeStamp = Date();
        print("check sendMQTT")
        let package : [String:Any] =
            
            [
                "client_name":"Siya",
                "client_number":"001",
                "client_location":"32.8743015,-117.2431993",
                "email_id": "simon678910@hotmail.com",
                //"email_id":"victor.moreno@compass-usa.com",
                //"sensor_MAC":"00:1e:c0:50:6a:a2",
                "sensor_MAC":"2e:1e:c9:70:6a:a2",
                "inspection_time":getCurrentTimeStamp(),
                "day":getCurrentDay(),
                "duration":getDuration(),
//                "operation":opeType, // Holding
//                "employee":"\(empname)", // John
//                "food_station":strStation,  // Lunch
//                "operation": "PRODUCTION",
                "operation": Functionalities.tt_operation_selected!.uppercased(),
                "employee": Functionalities.tt_fh_selected!,
                "food_station": Functionalities.tt_station_selected!,
                //test above
                "supplier": "None",
     //           "supplier": Functionalities.tt_vendor_selected!,  // None
                "food_name": Functionalities.tt_fooditem_selected!,
              //  "temperature": 136.0,
//                "food_name":strFood,    //Eggs
                "temperature":self.recordedTempIs,
                "corrective_action":correctiveAction,
                "notes":Functionalities.notes
        ]
        print("recordedTEMPTEMP \(self.recordedTempIs)")
        
        print("data \(package)")
        
        let data = try! JSONSerialization.data(withJSONObject: package, options: .prettyPrinted)
        //let data: Data = NSKeyedArchiver.archivedData(withRootObject: package)
        
        
        print("package :: \(package) connection status :: \(String(describing: self.mqttClient?.isConnected))" )

        //self.mqttClient?.publish(data, topic: Functionalities.mqttTopic, qos: 2, retain: false)
        
        self.mqttClient?.publish(data, topic: "probe", qos: 2, retain: false)
       // self.mqttClient?.subscribe("probe",qos: 2)
        print("TRIED")
        //mqttClient.disconnect()
    }

    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        // disconnect
        self.mqttClient?.disconnect()
        self.peripheral?.disconnect(completion: { result in
            
        })
        
        DispatchQueue.main.async {
            self.Indicator.stopAnimating()
            self.Indicator.isHidden = true
            
        }
//        if sender.tag == 1001{
//
//            self.navigationController?.popViewController(animated: true)
//        }
//        else{
//            self.navigationController?.popToRootViewController(animated: true)
//        }
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func recordButtonClicked(_ sender: Any) {
        initObserver()
        connectMosquito()
        self.btnRecord.isEnabled = false
        self.btnSubmit.isHidden = false
        self.btnSubmit.setTitle("", for: .normal)
    }
    
    @IBAction func addNote(_ sender: Any) {
        let alertController = UIAlertController(title: "Adding Note", message: "Please add/edit your message:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let note_field = alertController.textFields![0]

            if note_field.text != "" /* as? UITextField*/ {
                
                Functionalities.notes = note_field.text
               
                
            } else {
                print("no user input")
                // user did not fill field
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            if Functionalities.notes != nil{
                textField.placeholder = "Current Note: " + Functionalities.notes!
            }else{
                textField.placeholder = "Current Note Null"
            }
        }
        
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func submitButtonClicked(_ sender: Any) {
        if(peripheral != nil && peripheral?.state == .connected && currentTempIs > 0.0)
        {
            self.view.isUserInteractionEnabled = false
            
            self.Indicator.startAnimating()
            self.Indicator.isHidden = false
            
//            let tag = sender.tag;
            var correctiveAction = ""
            if self.btnSubmit.title(for: .normal) == "Take Corrective Action"{
                correctiveAction = Functionalities.tt_corrAction_selected!
            }else{
                correctiveAction = "Not Required"
            }
            sendToMQTT(correctiveAction: correctiveAction)
            
//            switch tag {
//            case 1:
//                correctiveAction = "Not Required"
//                break
//            case 2:
//                correctiveAction = "Reject Food"
//                break
//            case 3:
//                correctiveAction = "Bring to Temp"
//                break
//            default:
//                correctiveAction = "Not Required"
//                break
//            }
            
            
        }
        else
        {
            print("submit button click currentTmp \(currentTempIs)")
            print("SUBMIT BUTTON CLICKED \((String(describing: peripheral))) \(String(describing: peripheral?.state))");
            
            showAlert()
        }
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
