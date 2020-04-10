//
//  AddLocationMapViewController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController, MKMapViewDelegate {
    var latitude: CLLocationDegrees? = 0.0
    var longitude: CLLocationDegrees? = 0.0
    var link: URL?
    
    override func viewDidLoad() {
        print(latitude)
        print(longitude)
        print(link)
    }
}
