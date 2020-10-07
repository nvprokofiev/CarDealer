//
//  FirstPhoto.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import Foundation

enum FirstPhotoType: String {
    case large
    case medium
    case small
}

struct FirstPhoto: Decodable {
    let large: String
    let medium: String
    let small: String
}
