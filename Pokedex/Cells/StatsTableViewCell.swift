//
//  StatsTableViewCell.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 30/11/23.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
    private let stackView = UIStackView()
    private let attackLabel = UILabel()
    private let defenseLabel = UILabel()
    
    static var identifier = "StatsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(attack: Int, defense: Int) {
        attackLabel.text = "Attack: \(attack)"
        defenseLabel.text = "Defense: \(defense)"
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
        setupStatsLabel()
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStatsLabel() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(attackLabel)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(defenseLabel)
        attackLabel.textAlignment = .right
        defenseLabel.textAlignment = .left
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
