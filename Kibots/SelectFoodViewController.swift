//
//  SelectFoodViewController.swift
//  Kibots
//
//  Created by Siya Li on 5/9/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class SelectFoodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var arrFood = [String]()
    var selected_food: String?
    
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var tblFood: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblFood.delegate = self
        self.tblFood.dataSource = self
        if Functionalities.tt_operation_selected == "Holding"{
            arrFood = Functionalities.holdingItems
        } else if Functionalities.tt_operation_selected == "Production"{
            arrFood = Functionalities.productionItems
        } else{
            // TEMPORARY
            arrFood = Functionalities.holdingItems
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func selectBtnClicked(_ sender: Any) {
        if(selected_food != nil){
            Functionalities.tt_fooditem_selected = selected_food
            print("checking" + Functionalities.tt_fooditem_selected!)
            Functionalities.enableRecord = true
            selectBtn.isEnabled = false
            selectBtn.setTitle("Selected", for: .normal)
            Functionalities().getMinMaxMap(station: Functionalities.tt_station_selected!)
            
        }else{
            
            let alertController = UIAlertController(title: "Alert", message: "please select one row", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrFood.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        
        //        let lblTitle = cell.contentView.viewWithTag(101) as! UILabel
        //        lblTitle.text = arrEmployee[indexPath.row]
        //        lblTitle.layer.cornerRadius = 5
        //        lblTitle.clipsToBounds = true
        //        cell.selectionStyle = .none
        cell.textLabel?.text = arrFood[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        selectBtn.isEnabled = true
        selectBtn.setTitle("Select", for: .normal)
        selected_food = arrFood[indexPath.row]
        
        if tableView.indexPathsForSelectedRows != nil {
            for i in tableView.indexPathsForSelectedRows!{
                let cell = tableView.cellForRow(at: i)
                cell?.selectionStyle = .none
                cell?.isSelected = false
            }
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .blue
        cell?.isSelected = true
        //        let opeview = self.storyboard?.instantiateViewController(withIdentifier: "OperationsVC") as! OperationsVC
        //        opeview.empName = arrEmployee[indexPath.row] as NSString
        //        self.navigationController?.pushViewController(opeview, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.0
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
