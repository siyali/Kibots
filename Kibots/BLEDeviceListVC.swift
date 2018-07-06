//
//  BLEDeviceListVC.swift
//  Kibots
//
//  Created by Siya Li on 3/14/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit
import SwiftyBluetooth
import CoreBluetooth

class BLEDeviceListVC: UITableViewController {

    var peripheralList = [Peripheral]()
    var peripheralName = [String]()
    
//    var backString = "< Back"
    
//    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    
    @IBAction func openMenu(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        indicator.isHidden = true
        //backButton.title = backString
        
        if(GlobalVariables.sharedManager.peripheral != nil)
        {
            
            if(GlobalVariables.sharedManager.peripheral?.state == .connected)
            {
                self.lblStatus.text = "Status:Connected"
                peripheralList.append(GlobalVariables.sharedManager.peripheral!)
                
                self.tableView.reloadData()
                
            }
            else
            {
                self.lblStatus.text = "Status:Disconnected"
            }
            
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func btnScanClicked(_ sender: Any) {
    
        indicator.startAnimating()
        indicator.isHidden = false
        
        
        SwiftyBluetooth.scanForPeripherals(withServiceUUIDs:  nil, timeoutAfter: 3600) { scanResult in
            switch scanResult {
            case .scanStarted:
                // print("scanning...")
                self.lblStatus.text = "Scanning..."
                break
            case .scanResult(let peripheral, let advertisementData, _):
                
                if let thermapen = advertisementData["kCBAdvDataLocalName"] {
                    
                    
                    self.addToTable(peripheral: peripheral, advData: thermapen as! String)
                    
                } else {
                    
                    self.addToTable(peripheral: peripheral, advData: "NA")
                    
                }
                
                
                // let deviceKey = [String](advertisementData.keys)[1]
                
                //self.deviceList.append("\(peripheral.name!) - \(peripheral.identifier) ")
                
                break
            case .scanStopped(let error):
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                // print("stopped... \(error?.errorDescription!)")
                if  (error != nil) {
                    
                    self.showError(error: (error?.errorDescription)!)
                }
                
                break
            }
            
        }
    }
    
    func addToTable(peripheral : Peripheral, advData : String) -> Void {
        
        
        if(advData.lowercased().contains("therma"))
        {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            
            lblStatus.text = "Status:Disconnected"
            
            DispatchQueue.main.async() {
                
                
                
                if(self.peripheralName.count > 0)
                {
                    print("Device already in list")
                }
                else
                {
                    self.peripheralList.append(peripheral)
                    self.peripheralName.append(advData)
                    
                    self.tableView.reloadData()
                }
                
            }
            
        }
        
    }
    
    
    func showError(error : String) -> Void {
        
        
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        
    }
    
    func doConnectToPeripheral(peripheral : Peripheral) -> Void {
        
        peripheral.connect(withTimeout: 360000) { result in
            
            
            self.indicator.isHidden = true
            
            switch result {
            case .success:
                GlobalVariables.sharedManager.peripheral = peripheral
                self.lblStatus.text = "Status:Connected"
            break // You are now connected to the peripheral
            case .failure(_):
                self.lblStatus.text = "Status:Connect failed!"
                break // An error happened while connecting
            }
        }
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peripheralList.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath)
        
        let peripheral = peripheralList[indexPath.row]
        //cell.textLabel?.text = peripheral.identifier.uuidString
        
        if let thermapen = peripheral.name {
            
            cell.textLabel?.text = thermapen.uppercased()
            
        } else {
            
            cell.textLabel?.text = "NA"
            
        }
        
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = peripheralList[indexPath.row]
        
        
        
        DispatchQueue.main.async() {
            
            self.indicator.startAnimating()
            self.indicator.isHidden = false
            
            self.doConnectToPeripheral(peripheral: peripheral)
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
