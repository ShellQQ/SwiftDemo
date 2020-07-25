//
//  CircularLayoutCollectionViewCell.swift
//  SwiftDemo
//
//  Created by Apple on 2020/7/25.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class CircularLayoutCollectionViewCell: WaterFallsLayoutCollectionViewCell {
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
}
