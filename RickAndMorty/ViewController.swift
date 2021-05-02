//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Sophie Jacquot  on 24/02/2021.
//

import UIKit

class ViewController :UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private enum Item: Hashable {
        case character(SerieCharacter)
    }
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .character(let serieCharacter):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
               
                var content = cell.contentConfiguration
            //                content.textLabel?.text = serieCharacter.name
            //                content.imageView?.loadImage(from: serieCharacter.imageURL) {
            //                    cell.setNeedsLayout()
//            }
            return cell
            }
            
        })
        
        let snapshot = createSnapshot(serieCharacters: [])
        diffableDataSource.apply(snapshot)

        
        NetworkManager.shared.fetchCharacters { (result) in
            switch result {
            case .failure(let error):
                print(error)

            case .success(let paginatedElements):
                let serieCharacters = paginatedElements.decodedElements
                let snapshot = self.createSnapshot(serieCharacters: serieCharacters)



                DispatchQueue.main.async {
                    self.diffableDataSource.apply(snapshot)
                }
            }
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.2))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(10))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        return layout
    }
    
    private func createSnapshot(serieCharacters: [SerieCharacter]) -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([.main])
        
        let items = serieCharacters.map(Item.character)

        snapshot.appendItems(items, toSection: .main)
        
        return snapshot
    }
  
   
}

extension ViewController {
    enum Section {
        case main
    }
}
