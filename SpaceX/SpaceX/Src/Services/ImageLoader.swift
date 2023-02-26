//
//  ImageLoader.swift
//  SpaceX
//
//  Created by Александр Головин on 21.02.2023.
//

import UIKit

class ImageLoader: UIImageView {
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    var imageURL: URL?

    let activityIndicator = UIActivityIndicatorView()

    func loadImageWithUrl(_ url: URL) {

        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url

        image = nil
        activityIndicator.startAnimating()

        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {

            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            if error != nil {
#if DEBUG
                print(error as Any)
#endif
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }

            DispatchQueue.main.async(execute: {

                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
