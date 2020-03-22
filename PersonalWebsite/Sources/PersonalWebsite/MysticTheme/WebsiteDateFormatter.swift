//
//  File.swift
//  
//
//  Created by cynber on 2/24/20.
//

import Foundation

extension DateFormatter {
    static var website: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}
