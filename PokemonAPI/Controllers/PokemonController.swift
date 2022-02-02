//
//  PokemonController.swift
//  PokemonAPI
//
//  Created by Mitya Kim on 1/30/22.
//

import UIKit

class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    static let pokemonEndpoint = "pokemon"
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        
        // 1 - URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) } // https://pokeapi.co/api/v2/
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndpoint) // https://pokeapi.co/api/v2/pokemon/
        let searchTermURL = pokemonURL.appendingPathComponent(searchTerm.lowercased()) // https://pokeapi.co/api/v2/pokemon/{searchTerm}
        print(searchTermURL)
        
        
        // 2 - Data Task
        URLSession.shared.dataTask(with: searchTermURL) { (data, _, error) in
            
            // 3 - Error headling
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.throwError(error)))
            }
            
            // 4 - Check for Data
            guard let data = data else { return completion(.failure(.noData)) }

            // 5 - Decode Data
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                print(error)
                print(error.localizedDescription)
                return completion(.failure(.throwError(error)))
            }
        }.resume()
    }
    
    static func fetchSpritePokemon(pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        
        let spriteURL = pokemon.sprites.classicSpriteURL
        
        URLSession.shared.dataTask(with: spriteURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.throwError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            guard let sprite = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            return completion(.success(sprite))
        }.resume()
    }
}
