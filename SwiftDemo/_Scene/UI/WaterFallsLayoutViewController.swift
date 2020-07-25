//
//  WaterFallsLayoutViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/7/25.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class WaterFallsLayoutViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    lazy var waterfallsFlowLayout: WaterFallsFlowLayout! = {
        let layout = WaterFallsFlowLayout()
        
        let margin: CGFloat = 8
        layout.delegate = self
        layout.numOfColumn = 3
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        
        return layout
    }()
    
    let cellIdentifier = "waterfallLayoutCell"
    
    let cellData = [
        ["text": "1", "color": UIColor(red: 248, green: 65, blue: 47)],
        ["text": "2", "color": UIColor(red: 234, green: 22, blue: 98)],
        ["text": "3", "color": UIColor(red: 157, green: 29, blue: 176)],
        ["text": "4", "color": UIColor(red: 104, green: 52, blue: 186)],
        ["text": "5", "color": UIColor(red: 62, green: 76, blue: 183)],
        ["text": "6", "color": UIColor(red: 16, green: 149, blue: 244)],
        ["text": "7", "color": UIColor(red: 0, green: 167, blue: 246)],
        ["text": "8", "color": UIColor(red: 1, green: 189, blue: 216)],
        ["text": "9", "color": UIColor(red: 0, green: 151, blue: 136)],
        ["text": "10", "color": UIColor(red: 72, green: 177, blue: 76)],
        ["text": "11", "color": UIColor(red: 136, green: 198, blue: 65)],
        ["text": "12", "color": UIColor(red: 207, green: 222, blue: 33)],
        ["text": "13", "color": UIColor(red: 254, green: 237, blue: 23)],
        ["text": "14", "color": UIColor(red: 254, green: 194, blue: 2)],
        ["text": "15", "color": UIColor(red: 254, green: 153, blue: 1)],
        ["text": "16", "color": UIColor(red: 255, green: 86, blue: 8)],
        ["text": "17", "color": UIColor(red: 123, green: 86, blue: 70)],
        ["text": "18", "color": UIColor(red: 158, green: 158, blue: 158)],
        ["text": "19", "color": UIColor(red: 118, green: 118, blue: 118)],
        ["text": "20", "color": UIColor(red: 96, green: 125, blue: 143)]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: waterfallsFlowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //collectionView.backgroundColor = .clear
        
        // 註冊 Cell
        collectionView.register(WaterFallsLayoutCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        view.addSubview(collectionView)
    }

}

extension WaterFallsLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! WaterFallsLayoutCollectionViewCell
        cell.label.text = cellData[indexPath.item]["text"]! as? String
        cell.initBackgroundView(color: cellData[indexPath.item]["color"] as! UIColor)
        
        return cell
    }
}

extension WaterFallsLayoutViewController: WaterfallsFlowLayoutDelegate {
    func waterfallsFlow(_ waterfallsFlowLayout: WaterFallsFlowLayout, itemHeightAt indexPath: IndexPath) -> CGFloat {
        //return CGFloat(arc4random_uniform(150) + 50)
        return CGFloat.random(in: 50...200)
    }
}

