//
//  SetupKitchenRTableViewController.swift
//  Kibots
//
//  Created by Siya Li on 2/27/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class SetupKitchenRTableViewController: UITableViewController {
//    let receivedDict = Functionalities.vendorDict[Functionalities.tappedVendor!]
    
//    var localKitchens = [String]()
    override func viewDidLoad() {
//        localKitchens = Functionalities.vendorKitchens
        super.viewDidLoad()
        Functionalities.vendorKitchenFoodList = []
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
        
        return Functionalities.vendorKitchens.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) //as? UITableViewCell
        
        Functionalities.tappedKitchenR = currentCell?.textLabel!.text
        Functionalities().getVendorDict()
        Functionalities().getVendorKitchenFoodList()

        Functionalities().getMinMaxMapWithVendor(vendor: Functionalities.tappedVendor!, station: Functionalities.tappedKitchenR!)
        //let receivedDict = Functionalities.vendorDict[Functionalities.tappedVendor!]

        print("check null")
        print(Functionalities.tappedKitchenR)

//        if receivedDict != nil{
//            Functionalities.receivedFoodItemList = receivedDict![Functionalities.tappedKitchenR!]!
//        }else{
//            Functionalities.receivedFoodItemList = []
//        }
        performSegue(withIdentifier: "fooditemRSeg", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kitchenRCell", for: indexPath)

        // Configure the cell...
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = Functionalities.vendorKitchens[indexPath.row]
        return cell
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Adding Kitchen Station", message: "Please input name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let field = alertController.textFields![0]
            if field.text != "" /* as? UITextField*/ {
                
                Functionalities.myUser?.addReceivingStation(vendor: Functionalities.tappedVendor!, station: field.text!)

                print("kitchen station added")
//                DispatchQueue.main.async{
                    //Functionalities().updateVendorDict(user: Functionalities.myUser!)
                    Functionalities.vendorKitchens.append(field.text!)
                    self.tableView.reloadData()
//                }
            } else {
                print("no user input")
                // user did not fill field
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Kitchen Station Name:"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
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
