//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: PrimaryTextField!
    @IBOutlet weak var passwordField: PrimaryTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.placeholder = "Email"
        passwordField.placeholder = "Password"
    }
    
}
