//
//  TitleTableViewCell.swift
//  Pokedex
//
//  Created by Ezequiel Barreto on 28/11/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    
    static var identifier = "TitleTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    private func setupViews() {
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
}
