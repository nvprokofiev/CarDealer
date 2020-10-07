//
//  BaseAPIClient.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import Foundation

class BaseAPIClient: APIClient {
    
    var session: URLSession
    
    init() {
        self.session = URLSession(configuration: .default)
    }
}
