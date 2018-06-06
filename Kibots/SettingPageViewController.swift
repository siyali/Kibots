//
//  HomePageViewController.swift
//  Kibots
//
//  Created by Siya Li on 2/12/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingPageViewController: UIViewController {

    
    @IBOutlet weak var userEmailLabel: UILabel!
//    @IBOutlet weak var actionsTableView: UITableView!
    
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: UIView!
    
    var menuShowing = false;
    
    @IBAction func openMenu(_ sender: Any) {
        if menuShowing{
            menuLeadingConstraint.constant = -320
            // userEmailBtn.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
        }else{
            menuLeadingConstraint.constant = 0
            // userEmailBtn.isHidden = true
            view.bringSubview(toFront: menuView)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        menuShowing = !menuShowing
    }
    
    @IBAction func settingClicked(_ sender: Any) {
        menuLeadingConstraint.constant = -320
        // userEmailBtn.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLeadingConstraint.constant = -320
        
        if Functionalities.myUser != nil{
            let user = Functionalities.myUser
            userEmailLabel.text = user?.email
            
        }
        Functionalities().getFoodHandlerList()
        Functionalities().getHoldingStations()
        Functionalities().getHoldingDict()
        Functionalities().getProductionStations()
        Functionalities().getProductionDict()
//        Functionalities().getVendorDict()
//        Functionalities().getVendorKitchens()
        Functionalities().getCorrActions()
        Functionalities().getVendorList()
//        Functionalities().getProductionDict(user: Functionalities.myUser!)
        
        
        
//        var tmpDict:[String: [String]] = [:]
//        tmpDict["Bagel Bar"] = ["Grape Jelly","Peanut Butter"]
    //FIRDatabase.database().reference().child("Users").child((Functionalities.myUser?.userID)!).child("Operations").child("Holding").child()
//        Functionalities.myUser?.addHoldingStation(station: "Bagel Bar")
//        Functionalities.myUser?.addHoldingFoodItem(station: "Bagel Bar", fooditem: "Peanut Butter")
//        Functionalities.myUser?.addHoldingFoodItem(station: "Bagel Bar", fooditem: "Grape Jelly")
//        Functionalities.myUser?.addHoldingStation(station: "Soups")
//        Functionalities.myUser?.addHoldingFoodItem(station: "Grill", fooditem: "Cheese")
//        Functionalities.myUser?.addHoldingFoodItem(station: "Grill", fooditem: "Liquid Egg")
//        Functionalities.myUser?.addReceivingVendor(vendor: "Sysco")
//        Functionalities.myUser?.addReceivingStation(vendor: "Sysco", station: "Protein")
//        Functionalities.myUser?.addReceivingFoodItem(vendor: "Sysco", station: "Protein", fooditem: "Por Loin")
//        Functionalities.myUser?.addReceivingFoodItem(vendor: "Sysco", station: "Protein", fooditem: "Por Shoulder")
       // print(FIRDatabase.database().reference().child("Users").child((Functionalities.myUser?.userID)!).child("Operations").child("Holding").child("Bagel Bar").value(forKey: "Grape Jelly")!)
        print("enddddd")
//        print(Functionalities.vendorDict)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func btnDeviceSetupClicked(_ sender: UIButton) {
//        let deviceList = self.storyboard?.instantiateViewController(withIdentifier: "vcBLEDeviceListVC") as! BLEDeviceListVC
//        
//        self.navigationController?.pushViewController(deviceList, animated: true)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
