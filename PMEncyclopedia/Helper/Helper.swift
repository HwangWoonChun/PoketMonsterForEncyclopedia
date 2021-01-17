//
//  Helper.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/15.
//

import UIKit

extension UIView {
    //xib load 
    func loadNib(nibName: String) -> UIView?  {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return nil }
        return view
    }
}

fileprivate var imageCache = NSCache<NSString, AnyObject>()
extension UIImageView {
    //downloadImage
    func downloadImage(from url: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: url) else { return }
        
        contentMode = mode
        //cached Image
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            DispatchQueue.main.async() { [weak self] in
                self?.image = cachedImage
            }
        } else {
            //downloadImage
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
    }
}
