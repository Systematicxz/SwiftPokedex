//
//  pokemonDetailViewController.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 25/11/23.
//

import UIKit

class pokemonDetailViewController: UIViewController {
    var pokemonToShow: Pokemon?
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

    }

    func setupViews() {
        view.backgroundColor = .white
        setupTableView()
        
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        view.addSubview(tableView)
        // registrar celda en la tabla
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
    }

    func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension pokemonDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Para cuando estén todas las celdas
        // PokemonDetailSection.allCases.count
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        if let pokemonSection = PokemonDetailSection(rawValue: 0) {
            
            switch pokemonSection {
            case .title:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
                else { fatalError("Not cell found") }
                
                if let pokemon = pokemonToShow {
                    cell.configure(title: pokemon.name)
                }
                
                return cell
            case .image:
                break
            case .info:
                break
            case .type:
                break
            case .description:
                break
            }
            
            return UITableViewCell()
        
        } else {
            fatalError("Section not exists")
        }
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
