//
//  DescriptionTableViewCell.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 30/11/23.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    private let descriptionLabel = UILabel()
    
    static var identifier = "DescriptionTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(description: String) {
        descriptionLabel.text = description
    }
    private func setupViews(){
        setupDescriptionLabel()
    }
    private func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(descriptionLabel)
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
