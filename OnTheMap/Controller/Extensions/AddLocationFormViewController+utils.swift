//
//  AddLocationFormViewController+utils.swift
//  OnTheMap
//
//  Created by David Jarrin on 4/9/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

extension AddLocationFormViewController {
    func isValidURL(string : String) -> Bool {

        if let url = URL(string: string) {

            return UIApplication.shared.canOpenURL(url)
        }

    return false
    }
}
