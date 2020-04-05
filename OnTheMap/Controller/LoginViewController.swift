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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: PrimaryButton!
    @IBOutlet weak var WarningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.placeholder = "Email"
        passwordField.placeholder = "Password"
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        setLoggingIn(true)
        OTMClient.login(username: emailField.text ?? "", password: passwordField.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    @IBAction func signUpTapped() {
        UIApplication.shared.open(OTMClient.Endpoints.signUp.url, options: [:], completionHandler: nil)
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            WarningLabel.text = ""
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            displayError(message: error?.localizedDescription ?? "")
        }
        setLoggingIn(false)
    }
    
    func displayError(message: String) {
        WarningLabel.text = message
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailField.isEnabled = !loggingIn
        passwordField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
    
}
