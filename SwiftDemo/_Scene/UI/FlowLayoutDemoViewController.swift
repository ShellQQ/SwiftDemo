//
//  FlowLayoutDemoViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/7/11.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class FlowLayoutDemoViewController: UIViewController {

    var collectionView: UICollectionView!
    
    
    
    lazy var circularFlowLayout: CircularCollectionViewLayout! = {
        let layout = CircularCollectionViewLayout()
        //layout.itemSize = CGSize(width: 45, height: 45)
        //layout.radius = 150
        layout.direction = .top
        
        return layout
    }()
    
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
    
    @IBOutlet weak var buttonStack: UIStackView!
    
    @IBAction func resetWaterFallLayout(_ sender: UIButton) {
        if !collectionView.collectionViewLayout.isKind(of: WaterFallsFlowLayout.self) {
            //changeLayout(layoutType: .waterfalls)
        }
    }
    
    @IBAction func resetCircularLayout(_ sender: UIButton) {
        if !collectionView.collectionViewLayout.isKind(of: CircularCollectionViewLayout.self) {
            //changeLayout(layoutType: .circular)
        }
        
        switch sender.tag {
        case 0:
            circularFlowLayout.direction = .top
        case 1:
            circularFlowLayout.direction = .bottom
        case 2:
            circularFlowLayout.direction = .left
        case 3:
            circularFlowLayout.direction = .right
        default:
            return
        }
        
        //changeLayout(layoutType: .circular)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initCollectionView()
    }
    
    private func initCollectionView() {

        // Initial Collection View, 初始設定 WaterFallsFlowLayout
        //collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: waterfallsFlowLayout)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: circularFlowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //collectionView.backgroundColor = .clear
        
        // 註冊 Cell
        //let cellXIB = UINib.init(nibName: cellIdentifier, bundle: Bundle.main)
        //collectionView.register(cellXIB, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(FlowDemoCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        view.addSubview(collectionView)
        
        //collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - buttonStack.bounds.height - 20)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -20).isActive = true
    }
    
    /*func changeLayout(layoutType: FlowLayoutType) {
        self.collectionView.collectionViewLayout.invalidateLayout()
        
        switch layoutType {
            case .waterfalls:
                collectionView.setCollectionViewLayout(waterfallsFlowLayout, animated: true)
            case .circular:
                collectionView.setCollectionViewLayout(circularFlowLayout, animated: true)
            default:
                print("layout type: \(layoutType)")
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FlowLayoutDemoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flowLayoutCell", for: indexPath) as! FlowDemoCollectionViewCell
        cell.label.text = cellData[indexPath.item]["text"]! as? String
        //cell.backgroundColor = cellData[indexPath.item]["color"] as? UIColor
        cell.initBackgroundView(color: cellData[indexPath.item]["color"] as! UIColor)
        
        return cell
    }
}

extension FlowLayoutDemoViewController: WaterfallsFlowLayoutDelegate {
    func waterfallsFlow(_ waterfallsFlowLayout: WaterFallsFlowLayout, itemHeightAt indexPath: IndexPath) -> CGFloat {
        //return CGFloat(arc4random_uniform(150) + 50)
        return CGFloat.random(in: 50...200)
    }
}


enum FlowLayoutType {
    case waterfalls
    case circular
    case cover
    case horizontalscroll
    case deleteItem
    case moveItem
}
