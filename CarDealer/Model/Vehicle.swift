//
//  Car.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import Foundation

struct Vehicle: Decodable {
    
    let trim: String
    let model: String
    let year: Int
    let make: String
    let price: Double
    let mileage: Int
    let image: FirstPhoto?
    let dealer: Dealer
    
    enum CodingKeys: String, CodingKey {
        case trim
        case model
        case year
        case make
        case price = "currentPrice"
        case mileage
        case image = "images"
        case dealer
    }
    
    enum ImageCodingKeys: String, CodingKey {
        case firstPhoto = "firstPhoto"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imageContainer = try container.nestedContainer(keyedBy: ImageCodingKeys.self, forKey: .image)
        trim = try container.decode(String.self, forKey: .trim)
        model = try container.decode(String.self, forKey: .model)
        year = try container.decode(Int.self, forKey: .year)
        make = try container.decode(String.self, forKey: .make)
        price = try container.decode(Double.self, forKey: .price)
        mileage = try container.decode(Int.self, forKey: .mileage)
        dealer = try container.decode(Dealer.self, forKey: .dealer)
        image = try? imageContainer.decode(FirstPhoto.self, forKey: .firstPhoto)
    }
}
