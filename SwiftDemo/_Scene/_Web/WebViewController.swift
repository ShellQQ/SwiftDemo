//
//  WebViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/4/11.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var webTable: UITableView!
    
    private let webTableLabels = ["Zoo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webTable.delegate = self
        webTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webTableLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "webcell", for: indexPath)
        
        cell.textLabel!.text = webTableLabels[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "gotoZooPage", sender: nil)
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
