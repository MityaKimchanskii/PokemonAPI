//
//  UIViewControllerExtension.swift
//  PokemonAPI
//
//  Created by Mitya Kim on 1/30/22.
//

import UIKit

extension UIViewController {
    
    func presentError(localizedError: LocalizedError) {
        let alertCotroller = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel)
        alertCotroller.addAction(dismissAction)
        present(alertCotroller, animated: true)
    }
}
