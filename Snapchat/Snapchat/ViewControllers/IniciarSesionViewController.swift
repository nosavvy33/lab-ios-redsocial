//
//  ViewController.swift
//  Snapchat
//
//  Created by Leon on 24/10/18.
//  Copyright © 2018 Leon. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        /* if let user = user {
         let uid = user.user.uid
         print("UID:::" + uid)
         }*/
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){(user,error) in
            if error != nil {
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {(user,error) in
                    if error != nil{
                        print("We got an error:\(String(describing: error))")
                    }else{
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                })
            }else{
            self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
        }
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

