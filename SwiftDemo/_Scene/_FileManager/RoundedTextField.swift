//
//  RoundedTextField.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/14.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    // 對文字縮排
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // 對文字縮排
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // 對文字縮排
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
}
