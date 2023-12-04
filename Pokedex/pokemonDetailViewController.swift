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
        tableView.delegate = self
        tableView.reloadData()
    }

    func setupViews() {
        view.backgroundColor = .systemBackground
        setupTableView()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(StatsTableViewCell.self, forCellReuseIdentifier: StatsTableViewCell.identifier)
        tableView.register(TypeTableViewCell.self, forCellReuseIdentifier: TypeTableViewCell.identifier)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
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
         PokemonDetailSection.allCases.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        if let pokemonSection = PokemonDetailSection(rawValue: row) {
            
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
                guard let
                        cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell
                else { fatalError("Not cell found") }
                if let pokemon = pokemonToShow {
                    cell.configure(imageUrl: pokemon.imageUrl)
                    print(pokemon.imageUrl)
                }
                return cell

            case .info:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: StatsTableViewCell.identifier, for: indexPath) as? StatsTableViewCell
                else { fatalError("Not cell found") }
                if let pokemon = pokemonToShow {
                    cell.configure(attack: pokemon.attack, defense: pokemon.defense)
                }
                return cell

            case .type:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: TypeTableViewCell.identifier, for: indexPath) as? TypeTableViewCell
                else { fatalError("Not cell found") }
                
                if let pokemon = pokemonToShow {
                    cell.configure(type: pokemon.type)
                }
                return cell
            case .description:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as? DescriptionTableViewCell
                else { fatalError("Not cell found") }
                if let pokemon = pokemonToShow {
                    cell.configure(description: pokemon.description)
                }
                return cell
            }        
        } else {
            fatalError("Section not exists")
        }
    }
}
extension pokemonDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        
        if let pokemonSection = PokemonDetailSection(rawValue: row) {
            switch pokemonSection {
            case .image:
                // Calc  alt basada en el tamaño de la imagen
                return tableView.frame.width  // La altura será igual al ancho de la tabla para mantener una relación de aspecto cuadrada
            default:
                return UITableView.automaticDimension // Para otras celdas, usa la alt automática
            }
        } else {
            return UITableView.automaticDimension // Si no se encuentra la sección, usa la alt automática
        }
    }
}
//extension UIImageView {
//    func loadFrom(URLAdress: String) {
//        guard let url = URL(string: URLAdress) else { return }
//        
//        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//            if let error = error {
//                print("cant charge the image: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data, let loadedImage = UIImage(data: data) else { return }
//            
//            DispatchQueue.main.async {
//                self?.image = loadedImage
//            }
//        }
//        .resume()
//    }
//}
//extension UIImageView {
//    func loadFrom(URLAdress: String) -> URLSessionDataTask? {
//        guard let url = URL(string: URLAdress) else { return nil }
//        
//        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//            if let error = error {
//                print("cant charge the image: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data, let loadedImage = UIImage(data: data) else { return }
//            
//            DispatchQueue.main.async {
//                self?.image = loadedImage
//            }
//        }
//        dataTask.resume()
//        return dataTask
//    }
//}
