//
//  FoodItemHPTableViewController.swift
//  Kibots
//
//  Created by Siya Li on 2/27/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class FoodItemHPTableViewController: UITableViewController {

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
        if Functionalities.tappedOperation == "Production"{
//            let pd = Functionalities.productionDict[Functionalities.tappedKitchenHP!]?.count
  //          let pd = Functionalities.productionDict[Functionalities.tappedKitchenHP!]?
        
            return Functionalities.productionItems.count
        }
        else{
            
            return Functionalities.holdingItems.count
            
        }

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fooditemHP", for: indexPath)

        // Configure the cell...
     
      
        if Functionalities.tappedOperation == "Holding" {
//            print("each row content")
//            print(Functionalities.holdingDict[Functionalities.tappedKitchenHP!]?[indexPath.row])
//            cell.textLabel?.text = Functionalities.holdingDict[Functionalities.tappedKitchenHP!]?[indexPath.row]
            cell.textLabel?.text = Functionalities.holdingItems[indexPath.row]
        }
        else if Functionalities.tappedOperation == "Production"{
//            cell.textLabel?.text = Functionalities.productionDict[Functionalities.tappedKitchenHP!]?[indexPath.row]
            cell.textLabel?.text = Functionalities.productionItems[indexPath.row]
        }
        else{
            print("this should not appear")
        }
        return cell
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Adding Food Item", message: "Please input name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let field = alertController.textFields![0]
            if field.text != "" /* as? UITextField*/ {
                if Functionalities.tappedOperation == "Holding"{
                    
//                    Functionalities.myUser?.addHoldingFoodItem(station: Functionalities.tappedKitchenHP!, fooditem: field.text!)
                    Functionalities.holdingItems.append(field.text!)
                    Functionalities.myUser?.updateHoldingFoodItem(station: Functionalities.tappedKitchenHP!, fooditem: Functionalities.holdingItems)
//                    FunctionalitiesholdingDict[Functionalities.tappedKitchenHP!]?.append(field.text!)
                }
                else if Functionalities.tappedOperation == "Production"{
//                    Functionalities.myUser?.addProductionFoodItem(station: Functionalities.tappedKitchenHP!, fooditem: field.text!)
                    Functionalities.myUser?.updateProductionFoodItem(station: Functionalities.tappedKitchenHP!, fooditem: Functionalities.productionItems)
//                    Functionalities.productionDict[Functionalities.tappedKitchenHP!]?.append(field.text!)
                }else{
                    print("this should not appear")
                }
                print("food item added")
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
