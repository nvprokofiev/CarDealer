//
//  VehicleCollectionViewCell.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-06.
//

import UIKit
import Kingfisher

protocol VehicleCollectionViewCellDelegate: class {
    func didTapDialButton(to url: URL)
}

class VehicleCollectionViewCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.secondaryLabel.cgColor
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = UIColor.label
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var phoneNumberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(didTapPhoneButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        return stackView
    }()
    
    weak var delegate: VehicleCollectionViewCellDelegate?
    private var phoneURL: URL?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        containerView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        containerView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        containerView.addSubview(phoneNumberButton)
        NSLayoutConstraint.activate([
            phoneNumberButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 6),
            phoneNumberButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            phoneNumberButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            phoneNumberButton.heightAnchor.constraint(equalToConstant: 30),
            phoneNumberButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6)
        ])
    }
    
    func set(_ vehicle: VehicleViewModel) {
        imageView.kf.setImage(with: vehicle.getImageURL(for: .medium))
        titleLabel.text = vehicle.title
        detailLabel.text = vehicle.details
        phoneNumberButton.setTitle(vehicle.phoneNumber, for: .normal)
        phoneURL = vehicle.phoneURL
    }
    
    @objc private func didTapPhoneButton() {
        
        guard let phoneURL = phoneURL else { return }
        
        delegate?.didTapDialButton(to: phoneURL)
    }
}
