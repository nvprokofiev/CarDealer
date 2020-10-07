//
//  String+Extensions.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-07.
//

import Foundation

extension String {
    
    func toPhoneFormat()-> String {
        return format(with: "+X (XXX) XXX-XXXX", phone: self)
    }
}

fileprivate extension String {
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}
