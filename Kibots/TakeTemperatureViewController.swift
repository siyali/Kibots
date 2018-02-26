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
        selectStationButton.layer.borderWidth = 1.0
        selectStationButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        selectStationButton.layer.cornerRadius = cornerRadius
        
        selectFoodItemButton.isHidden = true
        selectFoodItemButton.layer.borderWidth = 1.0
        selectFoodItemButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        selectFoodItemButton.layer.cornerRadius = cornerRadius
        
        recordButton.isEnabled = false
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
