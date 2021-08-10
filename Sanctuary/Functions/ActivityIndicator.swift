//
//  ActivityIndicator.swift
//  Sanctuary
//
//  Created by Valados on 25.08.2020.
//  Copyright © 2020 Valados. All rights reserved.
//
import UIKit

fileprivate var foregroundView: UIView?

extension UIViewController{
    func showSpinner(alpha: CGFloat){
    foregroundView = UIView(frame: self.view.bounds)
        foregroundView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: alpha)
         let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.frame.size.width = 75
        imageView.frame.size.height = 75
        imageView.center = self.view.center
        imageView.animationImages = animatedImages(for: "ActivityIndicator")
        imageView.animationDuration = 0.4
        imageView.animationRepeatCount = 100
        imageView.image = imageView.animationImages?.first
        imageView.startAnimating()
        foregroundView?.addSubview(imageView)
        self.view.addSubview(foregroundView!)
    }
    func removeSpinner(){
        foregroundView?.removeFromSuperview()
        foregroundView = nil
    }
    func animatedImages(for name: String) -> [UIImage] {
           
           var i = 0
           var images = [UIImage]()
           
           while let image = UIImage(named: "\(name)/\(i)") {
               images.append(image)
               i += 1
           }
           return images
       }}
