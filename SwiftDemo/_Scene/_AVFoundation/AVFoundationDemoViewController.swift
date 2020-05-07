//
//  AVFoundationDemoViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/6.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class AVFoundationDemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var demoTable: UITableView!
    
    private let demoLabels = ["Camera"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        demoTable.delegate = self
        demoTable.dataSource = self
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "avcell", for: indexPath)
        
        cell.textLabel!.text = demoLabels[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = "goto\(demoLabels[indexPath.item])Page"
        self.performSegue(withIdentifier: identifier, sender: nil)
    }

}
