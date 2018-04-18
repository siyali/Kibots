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

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        
        print("end adding")
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        //Looks for single or multiple taps.
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
//        //tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
        self.emailTextField.resignFirstResponder()
        
        self.passwordTextField.resignFirstResponder()
        return true
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
                Functionalities.myUser = User(emailAdd: self.emailTextField.text!, uid: (FIRAuth.auth()?.currentUser!.uid)!)
                

                
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
//        if FIRAuth.auth()?.currentUser != nil{
//            Functionalities.myUser = User(emailAdd: emailTextField.text!, uid: (FIRAuth.auth()?.currentUser!.uid)!)
//            if !(Functionalities.myUser?.userExist(user: Functionalities.myUser!))! {
//                Functionalities.myUser?.addUserProfile()
//                print("login user added")
//            }
//            print("login user recorded")
//        }

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
