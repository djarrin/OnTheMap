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
        
        OTMClient.studentListings(limit: 100, skip: nil, order: nil, uniqueKey: nil) { (listings, error) in
            ListingModel.studentListings = listings
            NotificationCenter.default.post(Notification(name: .refreshAllTabs))
        }
    }
}

extension Notification.Name {
    static let refreshAllTabs = Notification.Name("RefreshAllTabs")
}
