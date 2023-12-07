//
//  Date+Extensions.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 07/12/2023.
//

import Foundation

extension Date {
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
