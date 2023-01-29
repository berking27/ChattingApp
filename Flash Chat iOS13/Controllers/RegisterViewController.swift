//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
     
     @IBOutlet weak var emailTextfield: UITextField!
     @IBOutlet weak var passwordTextfield: UITextField!
     
     @IBAction func registerPressed(_ sender: UIButton) {
          
          if let email = emailTextfield.text , let password = passwordTextfield.text{ //To avoid optional string error
               //Password and email can not be a nil
               Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error{
                         // Create an Alert
                         let dialogMessage = UIAlertController(title: "Attention", message: e.localizedDescription, preferredStyle: .alert)
                         // Create OK button with action handler
                         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                          })
                         //Add OK button to a dialog message
                         dialogMessage.addAction(ok)
                         // Present Alert to
                         self.present(dialogMessage, animated: true, completion: nil)
                         //End of Creating Alert
                         
                    } else {
                         //Navigate to the ChatViewController
                         self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    }
               }
          }
          
     }
     
}
