//
//  LoginViewController.swift
//  Kibots
//
//  Created by Siya Li on 2/12/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        print("login button clicked")
        
        //validate all the fields required to register an account
        if (emailTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)! {
            //show alert
            //showMessage(message: "please fill out all fields")
            let alertController = UIAlertController(title: "Alert", message: "please fill out all required fields", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
            //activityIndicator.stopAnimating()
        }
        
        //Instantiate an activity indicator placed in the center
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = view.center
        
        //activityIndicator.hideWhenStopped = false
        
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        
        //ready to send request to firebase and authenticate
        FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            
            if error == nil {
                print("You have successfully logged in")
                //Goes to home page
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController")
                self.present(vc!, animated: true, completion: nil)
                
            } else {
 //               self.showMessage(message: (error?.localizedDescription)!)
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)

                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)

                self.present(alertController, animated: true, completion: nil)
                activityIndicator.stopAnimating()
            }
        }
        if FIRAuth.auth()?.currentUser != nil{
            Functionalities.myUser = User(emailAdd: emailTextField.text!, uid: (FIRAuth.auth()?.currentUser!.uid)!)
            if !(Functionalities.myUser?.userExist(user: Functionalities.myUser!))! {
                Functionalities.myUser?.addUserProfile()
                print("login user added")
            }
            print("login user recorded")
        }

    }
    @IBAction func registerButtonClicked(_ sender: Any) {
        print("register button clicked")
        
        
        // go to the register view
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.present(registerViewController, animated: true)
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
