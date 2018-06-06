//
//  HomeViewController.swift
//  Kibots
//
//  Created by Siya Li on 5/21/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var menuShowing = false;
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var userEmailBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLeadingConstraint.constant = -320
        if Functionalities.myUser != nil{
            let user = Functionalities.myUser
            
            userEmailBtn.setTitle(user?.email, for: .normal)
            
        }
        Functionalities().getFoodHandlerList()
        Functionalities().getHoldingStations()
        Functionalities().getHoldingDict()
        Functionalities().getProductionStations()
        Functionalities().getProductionDict()
        Functionalities().getCorrActions()
        Functionalities().getVendorList()
      
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func homeButtonClicked(_ sender: Any) {
        menuLeadingConstraint.constant = -320
        // userEmailBtn.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = false
    }
    
    @IBAction func connectBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "homeToDevice", sender: self)
//        DispatchQueue.main.async {
//            print("going once")
//            self.performSegue(withIdentifier: "homeToDevice", sender: self)
//        }
        
    }
    
    @IBAction func settingBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "homeToSetting", sender: self)
//        DispatchQueue.main.async {
//            print("going once")
//            self.performSegue(withIdentifier: "homeToSetting", sender: self)
//        }
        
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            print("going once")
//            self.performSegue(withIdentifier: "homeToSetting", sender: self)
//        })
    }
    
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
