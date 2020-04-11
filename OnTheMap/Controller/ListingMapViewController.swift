//
//  ListingMapViewController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit
import MapKit

class ListingMapViewController: MapViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setNavigation()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshMap), name: .refreshAllTabs, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func refreshMap(){
        let listings = ListingModel.studentListings
        
        var annotations = [MKPointAnnotation]()
        
        for dictionary in listings {
            let lat = CLLocationDegrees(dictionary.latitude)
            let long = CLLocationDegrees(dictionary.longitude)
            
            let cordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let firstName = dictionary.firstName
            let lastName = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = cordinate
            annotation.title = "\(firstName) \(lastName)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
    
}

