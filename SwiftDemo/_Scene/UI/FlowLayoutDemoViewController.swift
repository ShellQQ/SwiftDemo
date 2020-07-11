//
//  FlowLayoutDemoViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/7/11.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class FlowLayoutDemoViewController: UIViewController {

    var waterfallsFlowLayout: WaterFallsFlowLayout!
    var circularFlowLayout: CircularFlowLayout!
    
    var collectionView: UICollectionView!
    
    let cellIdentifier = "flowLayoutCell"
    
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
        initCollectionView()
    }
    
    private func initCollectionView() {
        
        let margin: CGFloat = 8
        
        // Flow Layout 初始化
        // -- WaterFallsFlowLayout
        waterfallsFlowLayout = WaterFallsFlowLayout()
        waterfallsFlowLayout.delegate = self
        waterfallsFlowLayout.numOfColumn = 3
        waterfallsFlowLayout.minimumLineSpacing = margin
        waterfallsFlowLayout.minimumInteritemSpacing = margin
        waterfallsFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        
        circularFlowLayout = CircularFlowLayout()
        
        // Initial Collection View, 初始設定 WaterFallsFlowLayout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: waterfallsFlowLayout)
        
        //collectionView.delegate = self
        collectionView.dataSource = self
        
        // 註冊 Cell
        //let cellXIB = UINib.init(nibName: "FlowDemoCollectionViewCell", bundle: Bundle.main)
        //collectionView.register(cellXIB, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(FlowDemoCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        view.addSubview(collectionView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FlowLayoutDemoViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flowLayoutCell", for: indexPath) as! FlowDemoCollectionViewCell
        cell.backgroundColor = cellData[indexPath.item]["color"] as? UIColor
        //cell.initBackgroundView(color: cellData[indexPath.item]["color"] as! UIColor)
        
        return cell
    }
}

extension FlowLayoutDemoViewController: WaterfallsFlowLayoutDelegate {
    func waterfallsFlow(_ waterfallsFlowLayout: WaterFallsFlowLayout, itemHeightAt indexPath: IndexPath) -> CGFloat {
        //return CGFloat(arc4random_uniform(150) + 50)
        return CGFloat.random(in: 50...200)
    }
}


enum flowLayoutType {
    case waterfalls
    case circular
    case cover
    case horizontalscroll
    case deleteItem
    case moveItem
}
