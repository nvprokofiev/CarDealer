//
//  CarsClient.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import Foundation

class CarsClient: BaseAPIClient {
        
    func getAllCars(_ completion: @escaping (Result<VehicleListings, APIError>) -> Void) {
        let request = CarsAPI.all.request
                
        fetch(with: request, decode: { json -> VehicleListings? in
            guard let container = json as? VehicleListings else { return nil }
            return container
        }, completion: completion)
    }
}
