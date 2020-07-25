//
//  WaterFallsFlowLayout.swift
//  SwiftDemo
//
//  Created by Apple on 2020/7/10.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

protocol WaterfallsFlowLayoutDelegate: class {
    func waterfallsFlow(_ waterfallsFlowLayout: WaterFallsFlowLayout, itemHeightAt indexPath: IndexPath) -> CGFloat
}

class WaterFallsFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate: WaterfallsFlowLayoutDelegate?

    // 列數
    var numOfColumn = 4
    
    // 佈局 frame Array
    fileprivate lazy var layoutAttributeArray: [UICollectionViewLayoutAttributes] = []
    
    // 每列高度
    fileprivate lazy var yArray: [CGFloat] = Array(repeating: self.sectionInset.top, count: self.numOfColumn)
    // 最大高度
    fileprivate var maxHeight: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        
        waterfallsLayout()
    }
    
    func waterfallsLayout() {
        // 每個item的寬度
        let itemW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(numOfColumn - 1)) / CGFloat(numOfColumn)
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        // 最小高度的索引
        var minHeightIndex = 0
        
        for j in layoutAttributeArray.count ..< itemCount {
            let indexPath = IndexPath(item: j, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let itemH = delegate?.waterfallsFlow(self, itemHeightAt: indexPath)
            
            // 找出最小高度的一列
            let value = yArray.min()
            minHeightIndex = yArray.firstIndex(of: value!)!
            
            // 算出 item y 座標
            var itemY = yArray[minHeightIndex]
            //大於第一行的高度才相加
            if j >= numOfColumn {
                itemY += minimumInteritemSpacing
            }
            // 算出 item x 座標
            let itemX = sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(minHeightIndex)
            
            attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: CGFloat(itemH!))
            layoutAttributeArray.append(attr)
            // 重新設置高度
            yArray[minHeightIndex] = attr.frame.maxY
        }
        maxHeight = yArray.max()! + sectionInset.bottom
        
        print("yarray: \(yArray)")
    }
}

extension WaterFallsFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 找出相交的那些，別全部返回
        return layoutAttributeArray.filter {$0.frame.intersects(rect)}
    }
    
    override var collectionViewContentSize: CGSize {
        // 寬度不能設置為0
        return CGSize(width: collectionView!.bounds.width, height: maxHeight)
    }
}
