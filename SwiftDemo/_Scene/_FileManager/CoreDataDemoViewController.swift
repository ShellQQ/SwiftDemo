//
//  CoreDataDemoViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit
import CoreData

class CoreDataDemoViewController: UIViewController {
    
    let app = UIApplication.shared.delegate as! AppDelegate
    var viewContext: NSManagedObjectContext!
    
    var shells: [Shell] = []
    var searchShells: [Shell] = []
    var isSearch: Bool = false
    
    @IBOutlet weak var shellTable: UITableView!
    
    @IBOutlet weak var shellSearchBar: UISearchBar!
    
    @IBAction func addNewShell(_ sender: UIBarButtonItem) {
        //self.performSegue(withIdentifier: "gotoAddNewShellPage", sender: sender)
        if let controller = storyboard?.instantiateViewController(withIdentifier: "addNewShell") as? addNewShellTableViewController {
            self.show(controller, sender: sender)
        }
    }
    
    @IBAction func deleteAllShell(_ sender: UIButton) {
        deleteAllData()
        shells = queryAllData()
        shellTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewContext = app.persistentContainer.viewContext
        

        // 顯示資料實際儲存位置
        print(NSPersistentContainer.defaultDirectoryURL())
        //deleteAllData()
        inserShellData(family_en: "Nautilidae", family_cn: "鸚鵡螺科", scientificName: "Nautilus pompilius", commonName: "鸚鵡螺", distributed: "印度太平洋區", quantity: 3, size: 15)
        inserShellData(family_en: "Pleurotomariidae", family_cn: "翁戎螺科", scientificName: "Entemnotrochus rumphii", commonName: "龍宮翁戎螺", distributed: "台灣、日本", quantity: 1, size: 20)
        
        shells = queryAllData()
        //queryWithPredicate(with: "鸚")
        
        shellTable.delegate = self
        shellTable.dataSource = self
        
        shellSearchBar.delegate = self

        //shellTable.reloadData()
    }
    
    // 插入貝殼資料
    func reloadData() {
        shells = queryAllData()
        shellTable.reloadData()
    }
    
    // 插入貝殼資料
    func inserShellData(family_en: String, family_cn: String, scientificName: String, commonName: String, distributed: String, quantity: Int16, size: Float) {
        let shellData = NSEntityDescription.insertNewObject(forEntityName: "Shell", into: viewContext) as! Shell
        shellData.family_en = family_en
        shellData.family_cn = family_cn
        shellData.scientificName = scientificName
        shellData.commonName = commonName
        shellData.distributed = distributed
        shellData.quantity = quantity
        shellData.size = size
        //shellData.photos = photo
        
        print("save")
        app.saveContext()
    }

    // 取得所有貝殼資訊
    func queryAllData() -> [Shell] {
        do {
            let allData = try viewContext.fetch(Shell.fetchRequest()) as! [Shell]
            for data in allData {
                print(String(reflecting: data.commonName))
            }
            return allData
        } catch {
            print(error)
        }
        return []
    }
    
    // 取得關鍵字貝殼資訊並排序
    func queryWithPredicate(with name: String) -> [Shell] {
        let fetchRequest: NSFetchRequest<Shell> = Shell.fetchRequest()
        // 搜尋貝殼關鍵字
        let predicate = NSPredicate(format: "commonName like '\(name)*'")
        fetchRequest.predicate = predicate
        
        // 依照科名排序
        let sort = NSSortDescriptor(key: "family_en", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            let allData = try viewContext.fetch(fetchRequest)
            for data in allData {
                print(String(reflecting: data.commonName))
            }
            return allData
        } catch {
            print(error)
        }
        
        return []
    }
    
    // 刪除全部貝殼資訊
    func deleteAllData() {
        let batch = NSBatchDeleteRequest(fetchRequest: Shell.fetchRequest())
        
        do {
            try app.persistentContainer.persistentStoreCoordinator.execute(batch, with: viewContext)
        } catch {
            print(error)
        }
    }
    
    // 刪除個別貝殼資訊
    func deleteWithPredicate(with name: String) {
        let fetchRequest: NSFetchRequest = Shell.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "commonName like '\(name)*'")
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            for data in result {
                viewContext.delete(data)
                print("delete success")
            }
            app.saveContext()
        } catch {
            print(error)
        }
    }

}

extension CoreDataDemoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return searchShells.count
        }
        else {
            return shells.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shellTable.dequeueReusableCell(withIdentifier: "shellCell", for: indexPath) as! ShellTableViewCell
        let shell =  isSearch ? searchShells[indexPath.row] : shells[indexPath.row]
        var quantity = ""

        if let photo = shell.photos {
            cell.photo.image = UIImage(data: photo as Data)
        }
        else {
            cell.photo.image = UIImage(named: "noImage")
        }
        cell.name.text = "\(shell.commonName ?? "無") / \(shell.scientificName ?? "UNKNOW")"
        cell.family.text = "\(shell.family_cn ?? "") / \(shell.family_en ?? "")"
        cell.distributed.text = shell.distributed ?? "分佈不明"
        
        for _ in 1 ... shell.quantity {
            quantity += "🐚"
        }
        
        cell.quantity.text = quantity
        
        return cell
    }
    
    // 表格向左滑，刪除欄位
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, sourceView, completionHandler) in
            if let shellName = self.shells[indexPath.item].commonName {
                print("indexPath \(indexPath)")
                print("delete \(shellName)")
                self.deleteWithPredicate(with: shellName)
                self.shells = self.queryAllData()
                self.shellTable.reloadData()
                //self.shellTable.deleteRows(at: [indexPath], with: .fade)
            }
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231.0 / 255.0, green: 76.0 / 255.0, blue: 60.6 / 255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
    
    // 表格向右滑，修改欄位
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title: "") { (action, sourceView, completionHandler) in
            
            completionHandler(true)
        }
        
        modifyAction.backgroundColor = UIColor.green
        modifyAction.image = UIImage(named: "edit")
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    /*
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     deleteWithPredicate(with: shells[indexPath.item].commonName!)
     }
     
     shellTable.reloadData()
     }*/
}

extension CoreDataDemoViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("search bar cancle")
        isSearch = false
        searchBar.text = ""
        shellTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText) \(searchText.count)")
        if searchText.count > 0  {
            isSearch = true
            searchShells = shells.filter({ (shell) -> Bool in
                if let name = shell.commonName {
                    return name.localizedCaseInsensitiveContains(searchText)
                }
                return false
            })
            //searchShells = queryWithPredicate(with: searchText)
        }
            
        else {
            isSearch = false
        }
        
        shellTable.reloadData()
    }
}
