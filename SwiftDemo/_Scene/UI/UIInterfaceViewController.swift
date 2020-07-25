//
//  UIInterfaceViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/7/10.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class UIInterfaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var UIInterfaceTable: UITableView!
    
    //let tableLabels = ["Waterfalls Flow", "Circular Flow", "Cover Flow", "Horizontal Scroll", "Delete Item", "Move Item"]
    let tableLabels = ["WaterFallsFlowLayout", "CircularLayout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIInterfaceTable.delegate = self
        UIInterfaceTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "uicell", for: indexPath)
        
        cell.textLabel!.text = tableLabels[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableLabels[indexPath.row])
        let identifier = "goto\(tableLabels[indexPath.item])Page"
        self.performSegue(withIdentifier: identifier, sender: nil)
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
