//
//  UIImageView+addition.swift
//  RickAndMorty
//
//  Created by Sophie Jacquot  on 01/05/2021.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, completion: (() -> Void)?) {
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            guard error == nil,
                  let httpResponse = urlResponse as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                return
            }

            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                completion?()
            }
        }

        task.resume()
    }
}
