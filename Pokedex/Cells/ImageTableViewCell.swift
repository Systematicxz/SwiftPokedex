//
//  ImageTableViewCell.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 30/11/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    private let imageViewCell  = UIImageView()
    static var identifier = "ImageTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageUrl: String) {
        imageViewCell.loadFrom(urlAddress: imageUrl)
    }
    
    func setupViews() {
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground
        contentView.addSubviews(imageViewCell)
        imageViewCell.contentMode = .scaleAspectFit
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageViewCell.heightAnchor.constraint(equalToConstant: 250),
            imageViewCell.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
}
extension UIImageView {
    func loadFrom(urlAddress: String) {
        guard let url = URL(string: urlAddress) else { return }
        
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
