//
//  ListingTableViewController.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/5/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class ListingTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: .refreshAllTabs, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func refreshTable() {
        tableView!.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListingModel.studentListings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListingCell")!
        
        let listing = ListingModel.studentListings[indexPath.row]
        
        cell.textLabel?.text = "\(listing.firstName) \(listing.lastName)"
        
        if isValidURL(string: listing.mediaURL) {
            cell.detailTextLabel?.text = listing.mediaURL
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        cell.imageView?.image = UIImage(systemName: "mappin")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let linkString = ListingModel.studentListings[indexPath.row].mediaURL
        if isValidURL(string: linkString) {
            UIApplication.shared.open(URL(string: linkString)!, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: "Invalid URL", message: "This user does not have a valid URL associated to their lcoation", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

