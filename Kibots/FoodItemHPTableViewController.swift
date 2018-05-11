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
        // gesture recognizer
//        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
//        self.view.addGestureRecognizer(longPressRecognizer)
        
        let holdToSet = UILongPressGestureRecognizer(target: self, action:#selector(self.longPressSet));
        holdToSet.minimumPressDuration = 1.00;
        self.view.addGestureRecognizer(holdToSet)
        //self.tableView.reloadData()
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(CalorieCountViewController.handleLongPress))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                print("index path")
                print(indexPath)
                // your code here, get the row for the indexPath or do whatever you want
            }
        }
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
   //     cell.detailTextLabel?.text = @" "
    
        cell.detailTextLabel?.isHidden = true
        var food_name: String?
        if Functionalities.tappedOperation == "Holding" {

            cell.textLabel?.text = Functionalities.holdingItems[indexPath.row]
            food_name = Functionalities.holdingItems[indexPath.row]
 
            

        }
        else if Functionalities.tappedOperation == "Production"{
//            cell.textLabel?.text = Functionalities.productionDict[Functionalities.tappedKitchenHP!]?[indexPath.row]
            cell.textLabel?.text = Functionalities.productionItems[indexPath.row]
            food_name = Functionalities.productionItems[indexPath.row]
        }
        else{
            print("this should not appear")
        }
        
        guard let tuple_text = Functionalities.minMaxMap[food_name!] else{
            return cell
        }
        let min_text = String(tuple_text.0)
        let max_text = String(tuple_text.1)
        cell.detailTextLabel?.isHidden = false
        cell.detailTextLabel?.text = "Min: " + min_text + "   Max: " + max_text
        
        return cell
    }
    
    @objc func longPressSet(longPressGestureRecognizer : UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)

            let rowIndex: Int = (self.tableView.indexPathForRow(at: touchPoint)?.row)!
            let alertController: UIAlertController = UIAlertController(title: "Setting Range", message: "Please input min and max temperature", preferredStyle: .alert);
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                let min_field = alertController.textFields![0]
                if min_field.text != "" /* as? UITextField*/ {
                    if Functionalities.tappedOperation == "Holding"{
                        print("heiheiheihei")
                        
                        //                    Functionalities.holdingItems.append(field.text!)
                        //                    Functionalities.myUser?.updateHoldingFoodItem(station: Functionalities.tappedKitchenHP!, fooditem: Functionalities.holdingItems)
                    }
                    else if Functionalities.tappedOperation == "Production"{
                        print("hahhahahahahha")
                        //                    Functionalities.myUser?.updateProductionFoodItem(station: Functionalities.tappedKitchenHP!, fooditem: Functionalities.productionItems)
                    }else{
                        print("this should not appear")
                    }
                    self.tableView.reloadData()
                    
                } else {
                    print("no user input")
                    // user did not fill field
                }
                let max_field = alertController.textFields![1]
                if max_field.text != "" {
                    if Functionalities.tappedOperation == "Holding"{
                        print("heyhey")
                        
                    
                    }
                    else if Functionalities.tappedOperation == "Production"{
                        print("hannah")
                        
                    }else{
                        print("this should not appear")
                    }
 
                    self.tableView.reloadData()
                }
               
                print("holding items content")
                print(Functionalities.holdingItems)
                print(Functionalities.holdingItems[rowIndex])
                
                let min_int: Int? = Int(min_field.text!)
                let max_int: Int? = Int(max_field.text!)
                let minmax = (min_int!, max_int!) as (Int, Int)
                if Functionalities.tappedOperation == "Holding" {
                    Functionalities.minMaxMap[Functionalities.holdingItems[rowIndex]] = minmax
                    print("minmaxmap updated")
                    print(Functionalities.minMaxMap)
                }else{
                    Functionalities.minMaxMap[Functionalities.productionItems[rowIndex]] = minmax
                }
                Functionalities.myUser?.updateMinMaxTemp(hpr: Functionalities.tappedOperation!, station: Functionalities.tappedKitchenHP!, fooditem: Functionalities.holdingItems[rowIndex], min: min_int!, max: max_int!)
                self.tableView.reloadData()
                
                
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Min Temp"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "Max Temp"
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        


    }
    @IBAction func addButtonClicked(_ sender: Any) {
        
        var min_tmp = 40
        var max_tmp = 140
        var minmax = (min_tmp, max_tmp)
        
        let alertController = UIAlertController(title: "Adding Food Item", message: "Please input name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let field = alertController.textFields![0]
            let minfd = alertController.textFields![1]
            let maxfd = alertController.textFields![2]
            
            
            
            
            if field.text != "" /* as? UITextField*/ {
                if Functionalities.tappedOperation == "Holding"{
                    Functionalities.holdingItems.append(field.text!)
                    Functionalities.myUser?.addHoldingFoodItem(station: Functionalities.tappedKitchenHP!, fooditem: field.text!)
                    if maxfd.text != ""{
                        
                        if let max_int = Int(maxfd.text!){
                            max_tmp = max_int
                            Functionalities.myUser?.addHoldingItemMax(station: Functionalities.tappedKitchenHP!, fooditem: field.text!, max: max_int)
                        }
                        
                        
                    }else{
                        Functionalities.myUser?.addHoldingItemMax(station: Functionalities.tappedKitchenHP!, fooditem: field.text!, max: 140)
                    }
                    if minfd.text != ""{
                        if let min_int = Int(minfd.text!){
                            min_tmp = min_int
                            Functionalities.myUser?.addHoldingItemMin(station: Functionalities.tappedKitchenHP!, fooditem: field.text!, min: min_int)
                        }
                    }else{
                        Functionalities.myUser?.addHoldingItemMin(station: Functionalities.tappedKitchenHP!, fooditem: field.text!, min: 40)
                    }
                    minmax = (min_tmp, max_tmp)
                    
                    
                }
                else if Functionalities.tappedOperation == "Production"{
                    Functionalities.productionItems.append(field.text!)
                    Functionalities.myUser?.addProductionFoodItem(station: Functionalities.tappedKitchenHP!, fooditem: field.text!)
                    if maxfd.text != ""{
                        
                        if let max_int = Int(maxfd.text!){
                            max_tmp = max_int
                            Functionalities.myUser?.addProductionItemMax(station: Functionalities.tappedKitchenHP!, fooditem: field.text!, max: max_int)
                        }
                        
                        
                    }else{
                        Functionalities.myUser?.addProductionItemMax(station: Functionalities.tappedKitchenHP!, fooditem: field.text!, max: 140)
                    }
                    if minfd.text != ""{
                        if let min_int = Int(minfd.text!){
                            min_tmp = min_int
                            Functionalities.myUser?.addProductionItemMin(station: Functionalities.tappedKitchenHP!, fooditem: field.text!, min: min_int)
                        }
                    }else{
                        Functionalities.myUser?.addProductionItemMin(station: Functionalities.tappedKitchenHP!, fooditem: field.text!, min: 40)
                    }
                    minmax = (min_tmp, max_tmp)
                    
                }else{
                    print("this should not appear")
                }
                Functionalities.minMaxMap[field.text!] = minmax
                
                
                
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
        if (editingStyle == .delete) {
            print("deleted")// handle delete (by removing the data from your array and updating the tableview)
           // tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            if Functionalities.tappedOperation == "Holding"{
                Functionalities.holdingItems.remove(at: indexPath.row)
                print("after delete")
                print(Functionalities.holdingItems)
                Functionalities.myUser?.updateHoldingWithMinMax(station: Functionalities.tappedKitchenHP!, foodItems: Functionalities.holdingItems, minmaxMap: Functionalities.minMaxMap)
            }
            else if Functionalities.tappedOperation == "Production" {
                Functionalities.productionItems.remove(at: indexPath.row)
                Functionalities.myUser?.updateProductionFoodItem(station: Functionalities.tappedKitchenHP!, fooditem: Functionalities.productionItems)
            }
            self.tableView.reloadData()
        }
//        if (editingStyle == .insert)
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
