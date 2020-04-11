//
//  AddLocationMapViewController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: MapViewController {
    var latitude: CLLocationDegrees? = 0.0
    var longitude: CLLocationDegrees? = 0.0
    var link: String?
    var locationString: String?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var PostListingButton: PrimaryButton!
    
    override func viewDidLoad() {
        mapView.delegate = self
        
        let annotation = MKPointAnnotation()
        
        let cordinate = CLLocationCoordinate2D(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
        
        annotation.coordinate = cordinate
        annotation.title = locationString
        annotation.subtitle = link
        
        mapView.addAnnotation(annotation)
        
        mapView.showAnnotations([annotation], animated: true)
        
        mapView.selectAnnotation(annotation, animated: true)
        
        let rectangleSide = 1500
        let region = MKCoordinateRegion( center: cordinate, latitudinalMeters: CLLocationDistance(exactly: rectangleSide)!, longitudinalMeters: CLLocationDistance(exactly: rectangleSide)!)
        
        mapView.setRegion(mapView.regionThatFits(region), animated: true)

    }
    
    @IBAction func postListing(_ sender: Any) {
        OTMClient.postStudentLocation(firstName: OTMClient.Auth.firstName, lastName: OTMClient.Auth.lastName, mapString: locationString ?? "", mediaURL: link ?? "", latitude: Double(latitude ?? 0.0), longitude: Double(longitude ?? 0.0)) { (response, error) in
            if let _ = response {
                OTMClient.studentListings() { (listings, error) in
                    // Need to reload data now that we should have some more to offer
                    ListingModel.studentListings = listings
                    NotificationCenter.default.post(Notification(name: .refreshAllTabs))
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                print(error)
            }
        }
    }
    
}
