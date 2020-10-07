//
//  Dealer.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import Foundation

struct Dealer: Decodable {
    let name: String
    let address: String
    let state: String
    let zip: String
    let city: String
    let phone: String
}
