//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Sophie Jacquot  on 24/02/2021.
//

import UIKit

class ViewController :UIViewController {
    
    let mainView = MainView()
    var dataSource: UICollectionViewDiffableDataSource<Section, SerieCharacter>?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCollectionView()
        getCharacters()
    }
    
    func setupCollectionView(){
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, SerieCharacter> {
            cell, indexPath, serieCharacter  in
            
            var content = cell.defaultContentConfiguration()
            content.text = serieCharacter.name
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, SerieCharacter>(collectionView: mainView.collectionView) {
            collectionView, indexPath, serieCharacter in
            
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: serieCharacter)
        }
    }
    
    
    func getCharacters() {
        NetworkManager.shared.fetchCharacters { [weak self] result in
            switch result{
            case .success(let serieCharacters):
                print(serieCharacters)
                self?.populate(with: serieCharacters)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func populate(with serieCharacters: [SerieCharacter]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SerieCharacter>()
        snapshot.appendSections([.main])
        snapshot.appendItems(serieCharacters)
        dataSource?.apply(snapshot)
    }
    
}



extension ViewController {
    enum Section {
        case main
    }
}
