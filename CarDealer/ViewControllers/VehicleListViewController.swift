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
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

    private lazy var collectionView = {
        UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
    }()
    
    private var dataSource: DataSource!
    
    private var vehicles: [Vehicle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        applySnapshot()
        
        fetchVehicles()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
            cell.backgroundColor = UIColor.green
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
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
            case .failure(let error):
                print("error")
            }
        }
    }
}

