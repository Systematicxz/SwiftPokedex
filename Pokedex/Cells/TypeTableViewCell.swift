//
//  TypeTableViewCell.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 30/11/23.
//

import UIKit

class TypeTableViewCell: UITableViewCell {
    
    private let typeLabel = UILabel()
    
    static var identifier = "TypeTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(type: String) {
        typeLabel.text = "Type: \(type)"
 
    }
    
    private func setupViews() {
        setupTypeLabel()
    }
    private func setupTypeLabel(){
        typeLabel.textAlignment = .center
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.systemFont(ofSize: 35)
        
        
        contentView.addSubview(typeLabel)
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            typeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            typeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
