//
//  UIImage_Ext.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

extension UIImage {
    
    // 設置圖片圓角
    func isRoundCorner(radius: CGFloat, corners: UIRectCorner) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
        // 開始圖形上下文
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        // 繪製路徑
        UIGraphicsGetCurrentContext()?.addPath(UIBezierPath(roundedRect: rect,
                                                            byRoundingCorners: corners,
                                                            cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        // 裁剪
        UIGraphicsGetCurrentContext()!.clip()
        // 將原圖片畫到圖型上下文內将原图片画到图形上下文
        self.draw(in: rect)
        UIGraphicsGetCurrentContext()!.drawPath(using: .fillStroke)
        guard let output = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        // 關閉上下文
        UIGraphicsEndImageContext()
        return output
    }
}
