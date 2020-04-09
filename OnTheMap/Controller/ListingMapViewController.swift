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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.blueBaby
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
      func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(control)
        if control == view.rightCalloutAccessoryView {
            let subTitle = view.annotation?.subtitle!
            
            if let urlString = subTitle {
                if isValidURL(string: urlString) {
                    UIApplication.shared.open(URL(string: urlString)!)
                } else {
                    let alert = UIAlertController(title: "Invalid URL", message: "This user does not have a valid URL associated to their lcoation", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
    }
}

