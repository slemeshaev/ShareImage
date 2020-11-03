//
//  Extensions.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 18.10.2020.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingLeft: CGFloat,
                paddingBottom: CGFloat,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}

extension UIApplication {
    
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
    
}

var imageCache = [String: UIImage]()

// расширение для UIImageView
extension UIImageView {
    // метод загрузки изображения
    func loadImage(with urlString: String) {
        // проверка на существование изображения в кэше
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        // ссылка на расположение изображения
        guard let url = URL(string: urlString) else { return }
        
        // извлечь содержимое ссылки
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // обработка ошибок
            if let error = error {
                print("Ошибка загрузки изображения с ошибкой \(error.localizedDescription)")
            }
            
            // данные изображения
            guard let imageData = data else { return }
            
            // установка изображения, используя данные
            let photoImage = UIImage(data: imageData)
            
            // установка ключа и значения для изображения в кэше
            imageCache[url.absoluteString] = photoImage
            
            // установка изображения
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
        
    }
}
