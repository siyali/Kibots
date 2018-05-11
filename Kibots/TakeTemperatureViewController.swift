//
//  TakeTemperatureViewController.swift
//  Kibots
//
//  Created by Siya Li on 2/26/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class TakeTemperatureViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var selectFHButton: UIButton!
    @IBOutlet weak var selectOperationButton: UIButton!
    @IBOutlet weak var selectStationButton: UIButton!
    @IBOutlet weak var selectFoodItemButton: UIButton!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // hard coded selections, used temporarily for record button testing
//        Functionalities.tt_fh_selected = "John"
//        Functionalities.tt_operation_selected = "Holding"
        Functionalities.tt_vendor_selected = "None"
//        Functionalities.tt_station_selected = "Lunch"
//        Functionalities.tt_fooditem_selected = "Eggs"
        
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        selectFHButton.setTitle("Select Food Handler", for: .normal)
        selectFHButton.layer.borderWidth = 1.0
        selectFHButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        selectFHButton.layer.cornerRadius = cornerRadius
        selectFHButton.clipsToBounds = true
        
        
        selectOperationButton.setTitle("Select Operation", for: .normal)
        selectOperationButton.layer.borderWidth = 1.0
        selectOperationButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        selectOperationButton.layer.cornerRadius = cornerRadius
        
        selectStationButton.isHidden = true
        selectStationButton.setTitle("Select Station", for: .normal)
        selectStationButton.layer.borderWidth = 1.0
        selectStationButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        selectStationButton.layer.cornerRadius = cornerRadius
        
        selectFoodItemButton.isHidden = true
        selectFoodItemButton.setTitle("Select Food Item", for: .normal)
        selectFoodItemButton.layer.borderWidth = 1.0
        selectFoodItemButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        selectFoodItemButton.layer.cornerRadius = cornerRadius
        // default value for food item button is "eggs", used temporarily for testing
        selectFoodItemButton.setTitle("Eggs", for: .normal)
        
        //recordButton.isEnabled = false
        recordButton.layer.borderWidth = 1.0
        recordButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        recordButton.layer.cornerRadius = cornerRadius
        
        temperatureLabel.layer.cornerRadius = temperatureLabel.frame.width/2
        temperatureLabel.text = "- ºF"
        temperatureLabel.backgroundColor = UIColor.gray
        temperatureLabel.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordButtonClicked(_ sender: Any) {
        if selectFoodItemButton.currentTitle != "Select Food Item"{
            let resultview = self.storyboard?.instantiateViewController(withIdentifier: "FoodResultVC") as! FoodResultVC
            resultview.opeType = Functionalities.tt_operation_selected!
            print("operation type selected")
            print(resultview.opeType)
            if resultview.opeType == "Holding"{
                resultview.opeTag = "1"
            }else if resultview.opeType == "Production"{
                resultview.opeTag = "2"
            }else{
                resultview.opeTag = "3"
            }
            resultview.strStation = Functionalities.tt_station_selected!
            resultview.empname = Functionalities.tt_fh_selected! as NSString
            resultview.strFood = Functionalities.tt_fooditem_selected!
//            let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//            navigationController.pushViewController(resultview, animated: true)
            
            //self.navigationController?.pushViewController(resultview, animated: true)
            performSegue(withIdentifier: "recordTemp", sender: self)
            print("push view done")
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
