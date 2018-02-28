//
//  RegisterViewController.swift
//  Kibots
//
//  Created by Siya Li on 2/12/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        print("register button clicked")
        
        //validate all the fields required to register an account
        if (emailTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)! {
            //show alert
            let alertController = UIAlertController(title: "Alert", message: "please fill out all required fields", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        //validate password
        if ((passwordTextField.text?.elementsEqual(repeatPasswordTextField.text!))! != true){
            //show alert
            let alertController = UIAlertController(title: "Alert", message: "please check your passwords/do not match", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        //Instantiate an activity indicator placed in the center
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = view.center
        
        //activityIndicator.hideWhenStopped = false
        
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        
        //ready to send request to firebase and authenticate
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error == nil {
                print("You have successfully signed up")
                print("register USERINFO")
                Functionalities.myUser = User(emailAdd: self.emailTextField.text!, uid: (FIRAuth.auth()?.currentUser!.uid)!)
                Functionalities.myUser?.addUserProfile()
                
                
                //Goes to home page

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController")
                self.present(vc!, animated: true, completion: nil)
                
                
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                activityIndicator.stopAnimating()
            }
        }


        
    }
    func showMessage(message:String) -> Void {
        DispatchQueue.main.async{
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel){
                (action:UIAlertAction!) in
                //once ok button clicked
                print("ok button clicked")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        print("cancel button clicked")
        
        self.dismiss(animated: true, completion: nil)
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
