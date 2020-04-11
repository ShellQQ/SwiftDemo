//
//  UIView_Ext.swift
//  SwiftDemo
//
//  Created by Apple on 2020/4/11.
//  Copyright © 2020 Nautilus. All rights reserved.
//
import UIKit

extension UIView {
    
    // 設定特定的圓角
    //      - 左上角：layerMinXMinYCorner
    //      - 左下角：layerMinXMaxYCorner
    //      - 右上角：layerMaxXMinYCorner
    //      - 右下角：layerMaxXMaxYCorner
    func roundCorners(cornerRadius: CGFloat, corners: CACornerMask) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.maskedCorners = corners
    }
    
    func roundAllCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
