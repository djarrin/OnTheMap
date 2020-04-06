//
//  ListingTableViewController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class ListingTableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: .refreshAllTabs, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func refreshTable() {
        print("table refresh")
    }
}
