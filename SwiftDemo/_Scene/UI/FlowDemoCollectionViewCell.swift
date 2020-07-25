//
//  FlowDemoCollectionViewCell.swift
//  SwiftDemo
//
//  Created by Apple on 2020/7/11.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class FlowDemoCollectionViewCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        let l = UILabel()
        
        l.font = UIFont(name: "futura", size: 36)
        l.textColor = .white
        
        return l
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                
            }
            else {
                
            }
        }
    }
    
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
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
 
        if layoutAttributes is CircularCollectionViewLayoutAttributes {
            let attributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
            self.layer.anchorPoint = attributes.anchorPoint
            self.center.x += (attributes.anchorPoint.x - 0.5) * self.bounds.width
            // .top, .bottom 位移 r 距離
            self.center.y += (attributes.anchorPoint.y - 0.5) * self.bounds.height
        }
    }
    
    func initBackgroundView(color: UIColor) {
        let backView = UIView()
        backView.backgroundColor = color
        self.backgroundView = backView
    }
}
