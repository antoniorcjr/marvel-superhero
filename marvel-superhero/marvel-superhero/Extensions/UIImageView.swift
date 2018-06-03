//
//  UIImage.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit
// Code getting from Stack overflow: https://stackoverflow.com/questions/44519925/swift-3-url-image-makes-uitableview-scroll-slow-issue

extension UIImageView {
    func loadImage(fromURL urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.addSubview(activityView)
        activityView.frame = self.bounds
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityView.startAnimating()

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            }

            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            }.resume()
    }
}
