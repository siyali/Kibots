//
//  SelectCAViewController.swift
//  Kibots
//
//  Created by Siya Li on 6/6/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class SelectCAViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var tblCA: UITableView!
    
    var arrCA = Functionalities.corrActions
    var selected_ca: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblCA.delegate = self
        self.tblCA.dataSource = self
        print("have loaded")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCA.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "caCell", for: indexPath)
        
        //        let lblTitle = cell.contentView.viewWithTag(101) as! UILabel
        //        lblTitle.text = arrEmployee[indexPath.row]
        //        lblTitle.layer.cornerRadius = 5
        //        lblTitle.clipsToBounds = true
        //        cell.selectionStyle = .none
        cell.textLabel?.text = arrCA[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectBtn.isEnabled = true
        selectBtn.setTitle("Select", for: .normal)
        selected_ca = arrCA[indexPath.row]
        
        print("hahah" + selected_ca!)
        if tableView.indexPathsForSelectedRows != nil {
            for i in tableView.indexPathsForSelectedRows!{
                //tableView.deselectRow(at: i, animated: false)
                let cell = tableView.cellForRow(at: i)
                cell?.selectionStyle = .none
                //cell?.accessoryType = .none
                cell?.isSelected = false
            }
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .blue
        cell?.isSelected = true
        
        
    }
    
    @IBAction func selectClicked(_ sender: Any) {
        if(selected_ca != nil){
            Functionalities.tt_corrAction_selected = selected_ca
            print("checking" + Functionalities.tt_corrAction_selected!)
            Functionalities.hideCA = false
            selectBtn.isEnabled = false
            selectBtn.setTitle("Selected", for: .normal)
            
        }else{
            
            let alertController = UIAlertController(title: "Alert", message: "please select one row", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.0
    }
}
