//
//  UIColor_Ext.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        let redValue = CGFloat(red) / 255
        let greenValue = CGFloat(green) / 255
        let blueValue = CGFloat(blue) / 255
        
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
    
    // 產生純色圖片
    func asImage(size: CGSize) -> UIImage? {
        var resultImage: UIImage? = nil
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            
            return resultImage
        }
        
        context.setFillColor(self.cgColor)
        context.fill(rect)
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
}
