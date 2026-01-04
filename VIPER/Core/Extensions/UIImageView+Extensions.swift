//
//  UIImageView+Extensions.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL?) {
        guard let url = url else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
