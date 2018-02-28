//
//  SetupOperationsTableViewController.swift
//  Kibots
//
//  Created by Siya Li on 2/25/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit
//var suboperations:[[String]] = [["Bagel Bar", "Deli Bar", "Salad Bar", "Grill", "Lunch", "Soups"],["Deli Bar", "Breakfast", "Grill", "Salad Bar", "Raw Products", "Aubon Pan", "Condiment Station", "Hand Tossed Salad"],["Sysco","US Foods"]];
//var suboperations:[[String]] = [[],[],[]]
var suboperations:[[String]] = [] // an array with length 2 containing kitchen stations for Holding and Production

var tappedRowIndex = 0;
var holdingSelected = false;
var productionSelected = false;

class SetupOperationsTableViewController: UITableViewController {

    @IBOutlet weak var backBarButton: UIBarButtonItem!
    var operations:[String] = ["Holding", "Production", "Receiving"];
    
    override func viewDidLoad() {
        print(Functionalities.vendorDict)
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = backBarButton;
        var stationAllHolding:[String] = []
        var stationAllProduction:[String] = []
        for (key,value) in Functionalities.holdingDict{
            stationAllHolding.append(key)
        }
        for (key,value) in Functionalities.productionDict{
            stationAllProduction.append(key)
        }
        if suboperations.isEmpty{
            suboperations.append(stationAllHolding)
            suboperations.append(stationAllProduction)
        }
        else{
            suboperations[0] = stationAllHolding
            suboperations[1] = stationAllProduction
        }
        print(suboperations)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return operations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "opCell", for: indexPath) as! operationCell
        print(operations[indexPath.row])
        
        // Configure the cell...
        //cell.textLabel?.text = operations[indexPath.row]
        cell.operationLabel.text = operations[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedRowIndex = indexPath.row
        print("tappedRowIndex at op")
        print(tappedRowIndex)
        if tappedRowIndex < 2{
            if tappedRowIndex == 0{
                holdingSelected = true
            }
            else{
                productionSelected = true
            }
            performSegue(withIdentifier: "subOpKitchenSeg", sender: self)
        }
        else{
            performSegue(withIdentifier: "subOpVendorSeg", sender: self)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
