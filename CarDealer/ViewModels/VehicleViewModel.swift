//
//  VehicleViewModel.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import Foundation

class VehicleViewModel {

    private let vehicle: Vehicle
    private lazy var dealerVM: DealerViewModel = {
        DealerViewModel(with: vehicle.dealer)
    }()
    
    init(with vehicle: Vehicle) {
        self.vehicle = vehicle
    }
    
    var title: String {
        return "\(vehicle.make) \(vehicle.model) \(vehicle.trim)"
    }
    
    var price: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale.current
        let number = NSNumber(value: vehicle.price)
        return formatter.string(from: number) ?? String(describing: vehicle.price)
    }
    
    var details: String {
        return "\(price) | \(vehicle.mileage)km | \(dealerVM.address)"
    }
    
    var phoneNumber: String {
        dealerVM.phoneNumber
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
    
    var phoneURL: URL? {
        dealerVM.phoneURL
    }
    
}
