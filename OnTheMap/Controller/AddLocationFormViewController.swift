//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class AddLocationFormViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIButton(type: .system)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        cancelButton.setTitle("CANCEL", for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        
        navigationItem.title = "Add Location"
    }
    
    @objc func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
}
