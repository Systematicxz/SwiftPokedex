//
//  pokemonDetailViewController.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 25/11/23.
//

import UIKit

class pokemonDetailViewController: UIViewController, UITableViewDelegate {
    var tableView = UITableView()
    var viewModel: PokemonDetailViewModel?
    
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
        viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if let pokemonSection = PokemonDetailSection(rawValue: row) {
            
            switch pokemonSection {
            case .title:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
                else { fatalError("Not cell found") }
                
                let title = viewModel?.getValueReusable(forSection: .title) as? String ?? ""
                    cell.configure(title: title)
                return cell
            case .image:
                guard let
                        cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell
                else { fatalError("Not cell found") }
                let imageURL = viewModel?.getValueReusable(forSection: .image) as? String ?? ""
                cell.configure(imageUrl: imageURL)
                return cell
                
            case .info:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: StatsTableViewCell.identifier, for: indexPath) as? StatsTableViewCell
                else { fatalError("Not cell found") }
                let infoData = viewModel?.getValueReusable(forSection: .info) as? (attack: Int, defense: Int) ?? (0,0)
                cell.configure(attack: infoData.attack, defense: infoData.defense)
                return cell
                
            case .type:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
                else { fatalError("Not cell found") }
                let type = viewModel?.getValueReusable(forSection: .type) as? String ?? ""
                cell.configure(title: type)
                return cell
            case .description:
                guard
                    let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
                else { fatalError("Not cell found") }
                let description = viewModel?.getValueReusable(forSection: .description) as? String ?? ""
                cell.configure(title: description)
                return cell
            }
        } else {
            fatalError("Section not exists")
        }
    }
}
