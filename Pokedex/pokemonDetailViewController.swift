//
//  pokemonDetailViewController.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 25/11/23.
//

import UIKit

class pokemonDetailViewController: UIViewController {
    var pokemonToShow: Pokemon?
    
    var nameLabel = UILabel()
    var typeLabel = UILabel()
    var attackLabel = UILabel()
    var defenseLabel = UILabel()
    var imageView = UIImageView()
    var descriptionLabel = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        if let pokemon = pokemonToShow {
            nameLabel.text = pokemon.name
            nameLabel.font = UIFont.systemFont(ofSize: 25)
            typeLabel.text = "Type: \(pokemon.type)"
            typeLabel.font = UIFont.systemFont(ofSize: 30)
            attackLabel.text = "Attack: \(pokemon.attack)"
            imageView.loadFrom(URLAdress: pokemon.imageUrl)
            descriptionLabel.text = "Description \(pokemon.description)"
            descriptionLabel.font = UIFont.systemFont(ofSize: 25)
            defenseLabel.text = "Defense: \(pokemon.defense)"
        }

    }
    func setupViews() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        attackLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        defenseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(nameLabel, imageView, attackLabel , defenseLabel, typeLabel, descriptionLabel)
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            
            attackLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            attackLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20), //espaciado desde el borde izquierdo de la imagen

            defenseLabel.topAnchor.constraint(equalTo: attackLabel.topAnchor),
            defenseLabel.leadingAnchor.constraint(equalTo: attackLabel.trailingAnchor, constant: 30), // espaciado horizontal entre los labels
            defenseLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20), // espaciado desde el borde derecho de la imagen

            // Res para mantener el mismo ancho/altura entre labels
            defenseLabel.widthAnchor.constraint(equalTo: attackLabel.widthAnchor),
            defenseLabel.heightAnchor.constraint(equalTo: attackLabel.heightAnchor),
            defenseLabel.centerYAnchor.constraint(equalTo: attackLabel.centerYAnchor),
            
            typeLabel.topAnchor.constraint(equalTo: attackLabel.bottomAnchor, constant: 15),
            typeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            
            descriptionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension UIImageView {
    func loadFrom(URLAdress: String) {
        guard let url = URL(string: URLAdress) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("cant charge the image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let loadedImage = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { 
                self?.image = loadedImage
            }
        }
        .resume()
    }
}
