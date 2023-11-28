//
//  Extensions.swift
//  Pokedex
//
//  Created by PEDRO MENDEZ on 25/11/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
