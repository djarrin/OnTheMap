//
//  ListingMapViewController+utils.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/7/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

extension ListingMapViewController {
    // Credit to Edouard Barbie for the code: https://stackoverflow.com/a/44663574/2769705
    // I'm still getting errors like -canOpenURL: failed for URL: "dddddddddd" - error: "Invalid input URL" which doesn't make much since to
    // me as I'm unwrapping and checking that it is an instance of URL
    
    func setNavigation() {
        let logoutButton = UIButton(type: .system)
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        logoutButton.setTitle("LOGOUT", for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoutButton)
        navigationItem.title = "On the Map"
        
        let refreshButton = UIButton(type: .system)
        refreshButton.setImage(UIImage(named: "icon_refresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        let refreshBarButton = UIBarButtonItem(customView: refreshButton)
        
        let postButton = UIButton(type: .system)
        postButton.setImage(UIImage(systemName: "plus"), for: .normal)
        postButton.addTarget(self, action: #selector(post), for: .touchUpInside)
        let postBarButton = UIBarButtonItem(customView: postButton)
        
        navigationItem.setRightBarButtonItems([refreshBarButton, postBarButton], animated: true)
    }
    
    @objc func logOut() {
        OTMClient.logout { (_, _) in
            if let lvc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                lvc.modalPresentationStyle = .overFullScreen
                self.present(lvc, animated: true, completion: nil)
            }
        }
    }
    
    @objc func refresh() {
        OTMClient.studentListings { (listings, error) in
            ListingModel.studentListings = listings
            NotificationCenter.default.post(Notification(name: .refreshAllTabs))
        }
    }
    
    @objc func post() {
        if let alnc = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationNavigationController") {
            self.present(alnc, animated: true, completion: nil)
        }
    }
}
