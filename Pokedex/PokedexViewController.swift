//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by 瑠璃 on 2018/12/16.
//  Copyright © 2018 瑠璃. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    var searchBar: UISearchBar!
    
    let loadJSON = LoadJSON.loadJSON
    var pokemons: [Pokemon]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBarFrame = navigationController!.navigationBar.bounds
        searchBar = UISearchBar(frame: navigationBarFrame)
        searchBar.delegate = self
        searchBar.placeholder = "フシギダネ"
        navigationItem.titleView = searchBar
        navigationItem.titleView!.frame = searchBar.frame
        
        loadJSON.loadPokemonJSON()
        pokemons = loadJSON.pokemons
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PokemonCollectionViewCell
        cell.button.setTitle(pokemons[indexPath.row].name, for: .normal)
        let image = UIImage(named: pokemons[indexPath.row].name)
        cell.button.setImage(image, for: .normal)
        cell.label.text = pokemons[indexPath.row].name
        return cell
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        if searchBar.text!.isEmpty {
            pokemons = loadJSON.pokemons
            collectionView.reloadData()
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        let name: String = searchBar.text!.applyingTransform(.hiraganaToKatakana, reverse: false)!
        for i in 0 ..< loadJSON.pokemons.count {
            if pokemons[i].name.contains(name) {
                pokemons = loadJSON.pokemons.filter({ $0.name.contains(name) })
                break
            }
            pokemons = loadJSON.pokemons
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    @IBAction func touch(_ sender: UIButton) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        performSegue(withIdentifier: "Stats", sender: nil)
        UserDefaults.standard.set(sender.currentTitle, forKey: "nameLabel")
        UserDefaults.standard.synchronize()
    }
    
}
