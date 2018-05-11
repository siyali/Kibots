//
//  SelectKSViewController.swift
//  Kibots
//
//  Created by Siya Li on 5/9/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class SelectKSViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var arrKitchen = [String]()
    var selected_kitchen: String?
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var tblKitchen: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblKitchen.delegate = self
        self.tblKitchen.dataSource = self
        if Functionalities.tt_operation_selected == "Holding" {
            Functionalities().getHoldingDict()
            arrKitchen = Functionalities.holdingStations
        } else if Functionalities.tt_operation_selected == "Production"{
            Functionalities().getProductionDict()
            arrKitchen = Functionalities.productionStations
        } else{
            // TEMPORARY
            arrKitchen = Functionalities.holdingStations
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrKitchen.count
        
    }
    @IBAction func selectBtnClicked(_ sender: Any) {
        if(selected_kitchen != nil){
            Functionalities.tt_station_selected = selected_kitchen
            print("checking" + Functionalities.tt_station_selected!)
            Functionalities.hideFood = false
            selectBtn.isEnabled = false
            selectBtn.setTitle("Selected", for: .normal)
            
        }else{
            
            let alertController = UIAlertController(title: "Alert", message: "please select one row", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kitchenCell", for: indexPath)
        
        //        let lblTitle = cell.contentView.viewWithTag(101) as! UILabel
        //        lblTitle.text = arrEmployee[indexPath.row]
        //        lblTitle.layer.cornerRadius = 5
        //        lblTitle.clipsToBounds = true
        //        cell.selectionStyle = .none
        cell.textLabel?.text = arrKitchen[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectBtn.isEnabled = true
        selectBtn.setTitle("Select", for: .normal)
        selected_kitchen = arrKitchen[indexPath.row]
        
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
