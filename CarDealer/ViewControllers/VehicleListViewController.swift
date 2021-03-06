//
//  ViewController.swift
//  CarDealer
//
//  Created by Nikolai Prokofev on 2020-10-05.
//

import UIKit

enum Section {
    case main
}

class VehicleListViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Vehicle>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Vehicle>
    
    private lazy var collectionView = {
        UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
    }()
    
    private var dataSource: DataSource!
    
    private var vehicles: [Vehicle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        setupCollectionView()
        createDataSource()
        applySnapshot()
        
        fetchVehicles()
    }
    
    private func configureNavigationController() {
        navigationItem.title = "Latest Cars"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.register(VehicleCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: VehicleCollectionViewCell.self))
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, vehicle) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VehicleCollectionViewCell.self), for: indexPath) as? VehicleCollectionViewCell else {
                return UICollectionViewCell()
            }
            let vehicleVM = VehicleViewModel(with: vehicle)
            cell.set(vehicleVM)
            cell.delegate = self
            return cell
        })
    }
    
    private func applySnapshot() {
        var snapshot: Snapshot = NSDiffableDataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(vehicles)
        dataSource.apply(snapshot)
    }
    
    private func createLayout()-> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(8), trailing: nil, bottom: .fixed(8))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func fetchVehicles() {
        CarsClient().getAllVehicles { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let listing):
                self.vehicles = listing.listings
                self.applySnapshot()
            case .failure:
                print("error")
            }
        }
    }
}

extension VehicleListViewController: VehicleCollectionViewCellDelegate {
    
    func didTapDialButton(to url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}

