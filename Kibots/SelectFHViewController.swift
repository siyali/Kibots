//
//  SelectFHViewController.swift
//  Kibots
//
//  Created by Siya Li on 5/9/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit

class SelectFHViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var tblEmployee: UITableView!
//    var indexPathForSelectedRow: IndexPath? { get }
    var arrEmployee = Functionalities.fhList
    var selected_emp: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblEmployee.delegate = self
        self.tblEmployee.dataSource = self
        print("have loaded")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrEmployee.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "handlerCell", for: indexPath)
        
//        let lblTitle = cell.contentView.viewWithTag(101) as! UILabel
//        lblTitle.text = arrEmployee[indexPath.row]
//        lblTitle.layer.cornerRadius = 5
//        lblTitle.clipsToBounds = true
//        cell.selectionStyle = .none
        cell.textLabel?.text = arrEmployee[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectBtn.isEnabled = true
        selectBtn.setTitle("Select", for: .normal)
        selected_emp = arrEmployee[indexPath.row]

        print("hahah" + selected_emp!)
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
        if(selected_emp != nil){
            Functionalities.tt_fh_selected = selected_emp
            print("checking" + Functionalities.tt_fh_selected!)
            Functionalities.hideOPE = false
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
