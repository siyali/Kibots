//
//  SetupFoodHandlerTableViewController.swift
//  Kibots
//
//  Created by Siya Li on 2/24/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit
import Firebase

class SetupFoodHandlerTableViewController: UITableViewController {

    @IBOutlet weak var backBarButton: UIBarButtonItem!
    
    var databaseHandle: FIRDatabaseHandle?
    var local_foodhandlers = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.leftItemsSupplementBackButton = true;
        self.navigationItem.backBarButtonItem = backBarButton;
        //self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // listen for update with the .Value event
//        ref.observeEventType(.Value) { (snapshot) in
//
//            var newItems = [FDataSnapshot]()
//
//            // loop through the children and append them to the new array
//            for item in snapshot.children {
//                newItems.append(item as! FDataSnapshot)
//            }
//
//            // replace the old array
//            self.items = newItems
//            // reload the UITableView
//            self.tableView.reloadData()
//        }
 
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
        print("init food_handlers count")
        //print(Functionalities().getFoodHandlerList())
        return Functionalities.fhList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "fhCell", for: indexPath) as! foodHandlerCell

 
        // Configure the cell...
//        cell.foodHandlerLabel.text = Functionalities.fhList[indexPath.row]
        cell.foodHandlerLabel.text = Functionalities.fhList[indexPath.row]
        return cell
    }
    

    @IBAction func addButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Adding Food Handler", message: "Please input name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let field = alertController.textFields![0]
            if field.text != "" /* as? UITextField*/ {
                
                
                // store the food handler data
//                Functionalities.myUser?.addFoodHandlerProfile(fh: field.text!)
                print("food handler added")
                Functionalities.fhList.append(field.text!)
                Functionalities.myUser?.updateFoodHandlerProfile(fh: Functionalities.fhList)
//                DispatchQueue.main.async{
                    self.tableView.reloadData()
  //              }

            } else {
                print("no user input")
                // user did not fill field
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Food Handler Name:"
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
