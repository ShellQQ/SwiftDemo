//
//  WaterFallsLayoutCollectionViewCell.swift
//  SwiftDemo
//
//  Created by Apple on 2020/7/25.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class WaterFallsLayoutCollectionViewCell: UICollectionViewCell {
    lazy var label: UILabel = {
        let l = UILabel()
        
        l.font = UIFont(name: "futura", size: 36)
        l.textColor = .white
        
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.roundCorners(cornerRadius: 10, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initBackgroundView(color: UIColor) {
        let backView = UIView()
        backView.backgroundColor = color
        self.backgroundView = backView
    }
}
