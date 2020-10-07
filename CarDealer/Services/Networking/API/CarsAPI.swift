//
//  CarsAPIClient.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import Foundation

enum CarsAPI {
    case all
}

extension CarsAPI: Endpoint {
    
    var path: String { "/assignment.json" }
}
