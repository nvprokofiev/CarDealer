//
//  DealerViewModel.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-07.
//

import UIKit

class DealerViewModel {
    private let dealer: Dealer
    
    init(with dealer: Dealer) {
        self.dealer = dealer
    }
    
    var address: String {
        return "\(dealer.city), \(dealer.state)"
    }
}
