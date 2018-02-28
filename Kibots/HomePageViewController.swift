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

class HomePageViewController: UIViewController {

    
    @IBOutlet weak var userEmailLabel: UILabel!
//    @IBOutlet weak var actionsTableView: UITableView!
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        print("logout button clicked")
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                present(vc, animated: true, completion: nil)
                print("You have successfully logged out")
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if Functionalities.myUser != nil{
            let user = Functionalities.myUser
            userEmailLabel.text = user?.email
            
        }
        Functionalities().getFoodHandlerList( user: Functionalities.myUser!)
        Functionalities().getOperationDict(user: Functionalities.myUser!)
//        var tmpDict:[String: [String]] = [:]
//        tmpDict["Bagel Bar"] = ["Grape Jelly","Peanut Butter"]
    //FIRDatabase.database().reference().child("Users").child((Functionalities.myUser?.userID)!).child("Operations").child("Holding").child()
        Functionalities.myUser?.addHoldingStation(station: "Bagel Bar")
        Functionalities.myUser?.addHoldingFoodItem(station: "Bagel Bar", fooditem: "Peanut Butter")
        Functionalities.myUser?.addHoldingFoodItem(station: "Bagel Bar", fooditem: "Grape Jelly")
        Functionalities.myUser?.addHoldingStation(station: "Grill")
        Functionalities.myUser?.addHoldingFoodItem(station: "Grill", fooditem: "Cheese")
        Functionalities.myUser?.addHoldingFoodItem(station: "Grill", fooditem: "Liquid Egg")
        Functionalities.myUser?.addReceivingVendor(vendor: "Sysco")
        Functionalities.myUser?.addReceivingStation(vendor: "Sysco", station: "Protein")
        Functionalities.myUser?.addReceivingFoodItem(vendor: "Sysco", station: "Protein", fooditem: "Por Loin")
        Functionalities.myUser?.addReceivingFoodItem(vendor: "Sysco", station: "Protein", fooditem: "Por Shoulder")
       // print(FIRDatabase.database().reference().child("Users").child((Functionalities.myUser?.userID)!).child("Operations").child("Holding").child("Bagel Bar").value(forKey: "Grape Jelly")!)
        print("enddddd")
//        print(Functionalities.vendorDict)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
