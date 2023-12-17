//
//  Double +.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/13.
//

import Foundation

extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedNumber
        } else {
            return String(format: "%.2f", self)
        }
    }
}
