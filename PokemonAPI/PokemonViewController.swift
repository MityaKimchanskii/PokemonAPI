//
//  ViewController.swift
//  PokemonAPI
//
//  Created by Mitya Kim on 1/30/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var searchPokemonSB: UISearchBar!
    @IBOutlet weak var imagePokemonIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPokemonSB.delegate = self
    }
    
    func updateView(pokemon: Pokemon) {
        PokemonController.fetchSpritePokemon(pokemon: pokemon) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let sprite):
                    
                    self.imagePokemonIV.image = sprite
                    self.nameLabel.text = pokemon.name
                    self.idLabel.text = String(pokemon.id)
                    
                case .failure(let error):
                    self.presentError(localizedError: error)
                }
            }
        }
    }
}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchterm = searchBar.text, !searchterm.isEmpty else { return }
        
        PokemonController.fetchPokemon(searchTerm: searchterm) { result in
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let pokemon):
                    self.updateView(pokemon: pokemon)
                case .failure(let error):
                    self.presentError(localizedError: error)
                }
            }
        }
    }
}

