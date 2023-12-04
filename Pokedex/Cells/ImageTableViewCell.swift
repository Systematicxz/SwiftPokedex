//
//  ImageTableViewCell.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 30/11/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    private let imageLabel  = UIImageView()
    static var identifier = "ImageTableViewCell"
    var pokemon: Pokemon?
    var dataTask: URLSessionDataTask?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
    }

    func configure(imageUrl: String) {
        dataTask?.cancel()
        imageView?.image = nil
        dataTask = imageView?.loadFrom(URLAdress: imageUrl)
        //imageLabel.loadFrom(URLAdress: imageUrl)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel()
       // imageView?.image = nil
    }
    func setupViews() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubviews(imageLabel)
        imageLabel.contentMode = .scaleAspectFill
        imageLabel.clipsToBounds = true
        imageLabel.contentMode = .center
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageLabel.widthAnchor.constraint(equalToConstant: 100),
            imageLabel.heightAnchor.constraint(equalToConstant: 100),
//            imageLabel.widthAnchor.constraint(equalTo: imageLabel.widthAnchor),
//            imageLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
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
extension UIImageView {
    func loadFrom(URLAdress: String) -> URLSessionDataTask? {
        guard let url = URL(string: URLAdress) else { return nil }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("cant charge the image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let loadedImage = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.image = loadedImage
            }
        }
        dataTask.resume()
        return dataTask
    }
}
