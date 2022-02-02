//
//  PokemonError.swift
//  PokemonAPI
//
//  Created by Mitya Kim on 1/30/22.
//

import Foundation

enum PokemonError: LocalizedError {
    
    case invalidURL
    case throwError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach API"
        case .throwError(let error):
            return error.localizedDescription
        case .noData:
            return "NO data"
        case .unableToDecode:
            return "Contact us"
        }
    }
}
