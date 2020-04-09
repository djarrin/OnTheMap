//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationFormViewController: UIViewController {
    @IBOutlet weak var LocationTextField: PrimaryTextField!
    @IBOutlet weak var LinkURLTextField: PrimaryTextField!
    @IBOutlet weak var SubmitButton: PrimaryButton!
    @IBOutlet weak var ErrorMessage: UILabel!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIButton(type: .system)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        cancelButton.setTitle("CANCEL", for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        
        navigationItem.title = "Add Location"
    }
    
    
    @IBAction func SubmitLocation(_ sender: Any) {
        loadingRequest(true)
        if LocationTextField.text == "" || LinkURLTextField.text == "" {
            loadingRequest(false)
            ErrorMessage.text = validationErrors.inputsEmpty.stringValue
            return
        }
        
        if !isValidURL(string: LinkURLTextField.text!) {
            loadingRequest(false)
            ErrorMessage.text = validationErrors.invalidLinkUrl.stringValue
            return
        }
        
        geocoder.geocodeAddressString(LocationTextField.text!) {(placemarks, error) in
            if let placemarks = placemarks {
                print(placemarks)
            } else {
                print(error)
            }
        }
    }
    
    func loadingRequest(_ requestSending: Bool) {
        ErrorMessage.text = ""
        if requestSending {
            ActivityIndicator.startAnimating()
        } else {
            ActivityIndicator.stopAnimating()
        }
        LocationTextField.isEnabled = !requestSending
        LinkURLTextField.isEnabled = !requestSending
        SubmitButton.isEnabled = !requestSending
    }
    
    @objc func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
}

enum validationErrors {
    case inputsEmpty
    case invalidLinkUrl
    case unableToFindLocation
    case serverError
    
    var stringValue: String {
        switch self {
        case .inputsEmpty: return "Both the location and Link URL fields must be filled in."
        case .invalidLinkUrl: return "The provided link is not a valid URL"
        case .unableToFindLocation: return "On the Map was not able to find the location entered"
        case .serverError: return "There was an issue processing your request, please try again later."
        }
    }
}
