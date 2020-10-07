//
//  VehicleCollectionViewCell.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import UIKit
import Kingfisher

class VehicleCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addImageView() {
        addSubview(imageView)
        
    }
    
    func set(_ vehicle: VehicleViewModel) {
        imageView.kf.setImage(with: vehicle.getImageURL(for: .medium))
    }
    
}
