//
//  VehicleViewModel.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import Foundation

class VehicleViewModel {

    private let vehicle: Vehicle
    
    init(with vehicle: Vehicle) {
        self.vehicle = vehicle
    }
    
    func getImageURL(for type: FirstPhotoType) -> URL? {
        guard let image = vehicle.image else {
            return nil
        }
        let mirror = Mirror(reflecting: image)

        for (name, value) in mirror.children where name == type.rawValue {
            if let urlPath = value as? String {
                return URL(string: urlPath)
            }
            return nil
        }
        return nil
    }
    
}
