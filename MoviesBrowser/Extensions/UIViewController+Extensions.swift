//
//  UIViewController+Extension.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 11/12/2023.
//

import UIKit

extension UIViewController {
    
    func showAlertWithTitle(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default))
    }
}
