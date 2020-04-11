//
//  PrimaryTabBarController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/6/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class PrimaryTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OTMClient.studentListings(limit: 100, order: "-updatedAt") { (listings, error) in
            ListingModel.studentListings = listings
            NotificationCenter.default.post(Notification(name: .refreshAllTabs))
            if let _ = error {
                let alert = UIAlertController(title: "Download Issue", message: "On the map was unable to download student locations. Please Try again later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension Notification.Name {
    static let refreshAllTabs = Notification.Name("RefreshAllTabs")
}
