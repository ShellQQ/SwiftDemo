//
//  FileManagerViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/4/20.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class FileManagerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var fileTable: UITableView!
    
    private let cellLabels = ["SaveImage", "CoreData"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileTable.delegate = self
        fileTable.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fileManagerCell", for: indexPath)
        
        cell.textLabel!.text = cellLabels[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = "goto\(cellLabels[indexPath.item])Page"
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
    
}
