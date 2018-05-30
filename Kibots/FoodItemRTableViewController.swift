//
//  FoodItemRTableViewController.swift
//  Kibots
//
//  Created by Siya Li on 2/27/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class FoodItemRTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return Functionalities.vendorKitchenFoodList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fooditemRCell", for: indexPath)
        cell.textLabel?.text = Functionalities.vendorKitchenFoodList[indexPath.row]
        let food_name = Functionalities.vendorKitchenFoodList[indexPath.row]
        cell.detailTextLabel?.isHidden = true
        print("Minmaxmap \(Functionalities.minMaxMap)")
        guard let tuple_text = Functionalities.minMaxMap[food_name] else{
            return cell
        }
        let min_text = String(tuple_text.0)
        let max_text = String(tuple_text.1)
        cell.detailTextLabel?.isHidden = false
        cell.detailTextLabel?.text = "Min: " + min_text + "   Max: " + max_text
        print("detailtextlabel \(cell.detailTextLabel)")
        
        return cell
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        var min_tmp = 40
        var max_tmp = 140
        var minmax = (min_tmp, max_tmp)
        let alertController = UIAlertController(title: "Adding Food Item", message: "Please input name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let field = alertController.textFields![0]
            let minfd =  alertController.textFields![1]
            let maxfd = alertController.textFields![2]
            if field.text != "" /* as? UITextField*/ {
                
                Functionalities.myUser?.addReceivingFoodItem(vendor: Functionalities.tappedVendor!, station: Functionalities.tappedKitchenR!, fooditem: field.text!)
                Functionalities.vendorKitchenFoodList.append(field.text!)
                if maxfd.text != ""{
                    if let max_int = Int(maxfd.text!){
                        max_tmp = max_int
                        
                    }
                }
                Functionalities.myUser?.addReceivingItemMax(vendor: Functionalities.tappedVendor!, station: Functionalities.tappedKitchenR!, fooditem: field.text!, max: max_tmp)
                if minfd.text != ""{
                    if let min_int = Int(minfd.text!){
                        min_tmp = min_int
                    }
                }
                Functionalities.myUser?.addReceivingItemMin(vendor: Functionalities.tappedVendor!, station: Functionalities.tappedKitchenR!, fooditem: field.text!, min: min_tmp)
                minmax = (min_tmp, max_tmp)
                Functionalities.minMaxMap[field.text!] = minmax
//                DispatchQueue.main.async{
                    self.tableView.reloadData()
//                }
            } else {
                print("no user input")
                // user did not fill field
            }
        
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Food Item Name:"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Default Min: 40"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Default Max: 140"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("Functionalities minmax Map \(Functionalities.minMaxMap)")
        if (editingStyle == .delete) {
            print("deleted")// handle delete (by removing the data from your array and updating the tableview)
            // tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            
            Functionalities.vendorKitchenFoodList.remove(at: indexPath.row)
            print("\(Functionalities.tappedVendor!)    \(Functionalities.tappedKitchenR!)     \(Functionalities.vendorKitchenFoodList)  \(Functionalities.minMaxMap) ")
            Functionalities.myUser?.updateReceivingWithMinMax(vendor: Functionalities.tappedVendor!, station: Functionalities.tappedKitchenR!, foodItems: Functionalities.vendorKitchenFoodList, minmaxMap: Functionalities.minMaxMap)
           
            self.tableView.reloadData()
        }
        
    }

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
