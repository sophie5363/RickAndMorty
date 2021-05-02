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
        case serieCharacter(SerieCharacter)
    }
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        setupCollectionView()
        //        getCharacters()
        
        collectionView.collectionViewLayout = createLayout()
        
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .item():
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            return cell
            }
            
        })
        
        let snapshot = createSnapshot()
        diffableDataSource.apply(snapshot)

    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(50))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        return layout
    }
    
    private func createSnapshot() -> NSDiffableDataSourceSnapshot<Section, SerieCharacter> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SerieCharacter>()
        snapshot.appendSections([.main])
//        snapshot.appendItems(serieCharacters)
        
        return snapshot
    }
    
    
    
//        func getCharacters() {
//            NetworkManager.shared.fetchCharacters { result in
//                switch result{
//                case .success(let serieCharacters):
//                    print(serieCharacters)
//                    self.populate(with: serieCharacters)
//
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
    //
    //    func populate(with serieCharacters: [SerieCharacter]) {
    //        var snapshot = NSDiffableDataSourceSnapshot<Section, SerieCharacter>()
    //        snapshot.appendSections([.main])
    //        snapshot.appendItems(serieCharacters)
    //        dataSource?.apply(snapshot)
    //    }
    
}

extension ViewController {
    enum Section {
        case main
    }
}
