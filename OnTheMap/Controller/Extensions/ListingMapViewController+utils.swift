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
    func isValidURL(string : String) -> Bool {

        if let url = URL(string: string) {

            return UIApplication.shared.canOpenURL(url)
        }

    return false
    }
}
