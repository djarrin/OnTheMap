//
//  ListingMapViewController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit
import MapKit

class ListingMapViewController: UIViewController, MKMapViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshMap), name: .refreshAllTabs, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func refreshMap(){
        print("map refreshing")
    }
}

