//
//  UIColor_Ext.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//
import UIKit

extension UIColor {

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
