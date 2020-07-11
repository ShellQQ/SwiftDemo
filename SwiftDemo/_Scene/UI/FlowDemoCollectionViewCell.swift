//
//  FlowDemoCollectionViewCell.swift
//  SwiftDemo
//
//  Created by Apple on 2020/7/11.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class FlowDemoCollectionViewCell: UICollectionViewCell {
    
    //var label: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                
            }
            else {
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initBackgroundView(color: UIColor) {
        self.backgroundColor = color
    }
}
