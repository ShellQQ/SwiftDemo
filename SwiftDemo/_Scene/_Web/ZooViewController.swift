//
//  ZooViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/4/11.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class ZooViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, URLSessionDownloadDelegate {
    
    @IBOutlet weak var zooTable: UITableView!
    
    // 儲存動物資料
    private var zooData = [AnyObject]()
    
    private let zooURL = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=a3e2b221-75e0-45c1-8f97-75acbd43d613"

    override func viewDidLoad() {
        super.viewDidLoad()

        getZooDataWithDownloadTask(dataURL: zooURL, description: "json data")
        
        zooTable.delegate = self
        zooTable.dataSource = self
    }
    
    /*// 使用URLSessionDataTask 讀取資料，將讀取完成得資料放在 data 變數中(不會儲存)
    func getAnimalImage(url: URL, completionHandler: @escaping (Data) -> ()) {
        /*guard let url = URL(string: dataURL) else {
         
         return
         }*/
        
        // 使用預設建立session (default：在硬碟中儲存快取資料)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // URLSessionDataTask 讀取資料，將讀取完成得資料放在 data (不會儲存)
        let dataTask = session.dataTask(with: url) {(data, response, error) in
            // 以下在另一個 thread 執行
            if (error == nil) {
                
                do {
                    DispatchQueue.main.async(execute: {
                        completionHandler(data!)
                    })
                    //self.zooTable.reloadData()
                } catch{
                    
                }
            }
            else {
                print("read error")
            }
        }
        dataTask.resume()
    }*/

    // 在背景中下載資料並存擋在 tmp/ 資料夾中
    func getZooDataWithDownloadTask(dataURL: String, description: String) {
        let url = URL(string: dataURL)
        let config = URLSessionConfiguration.default
        // 如果 delegateQueue 為 OperationQueue.main, 則會在主執行緒中執行, nil 則否
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        let downloadTask = session.downloadTask(with: url!)
        downloadTask.taskDescription = description
        downloadTask.resume()
    }
    
    // 取得目前下載進度，只有當App在前景時才會呼叫
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) * 100
        print("目前下載進度: \(progress)")
    }
    
    // 檔案下載完成並存擋後呼叫
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        if let data = try? Data(contentsOf: location) {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:[String:AnyObject]]
                
                self.zooData = jsonData["result"]!["results"] as! [AnyObject]
                self.zooTable.reloadData()
                
            } catch {}
        }
    }
    
    // 下載完成得知是否有錯誤產生
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error == nil {
            print("下載成功")
            //print("identifier: \(task.taskIdentifier)")
            //print("descritpion: \(String(describing: task.taskDescription))")
            //print("current request: \(String(describing: task.currentRequest))")
            //print("original request: \(String(describing: task.originalRequest))")
            //print("response: \(String(describing: task.response))")
        }
        else {
            print("下載失敗")
        }
    }
    
    // 當 App 從背景變前景時通知使用者下載已經完成
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("下載程式完成並回到前景")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("data number \(zooData.count)")
        return zooData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zoocell", for: indexPath) as! ZooTableViewCell
    
        let animal = zooData[indexPath.row]
        let ch_name = animal["A_Name_Ch"] as? String ?? "unknow"
        let en_name = animal["A_Name_En"] as? String ?? " unknow "
        let phylum = animal["A_Phylum"] as? String ?? " unknow "
        let aclass = animal["A_Class"] as? String ?? " unknow "
        let order = animal["A_Order"] as? String ?? " unknow "
        let family = animal["A_Family"] as? String ?? " unknow "
        
        cell.animalName.text = ch_name + " / " + en_name
        cell.animalClass.text = phylum + " / " + aclass + " / " + order + " / " + family
        
        if let imageURL = animal["A_Pic01_URL"] as? String {
            cell.getAnimalImage(dataURL: imageURL)
        }
        
        /*if let imageURL = animal["A_Pic01_URL"] as? String, let url = URL(string: imageURL) {
            
            getAnimalImage(url: url) { (data) in
                cell.animalImage.image = UIImage(data: data)
            }
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            print("image url: \(imageURL)")
            let dataTask = session.dataTask(with: URL(string: imageURL)!) {(data, response, error) in
                // 以下在另一個 thread 執行
                if (error == nil) {
                    if let data = data, let image = UIImage(data: data) {
                        print("圖片下載成功")
                        DispatchQueue.main.async {
                            cell.animalImage.image = image
                        }
                    }
                }
                else {
                    print("read error \(error)")
                }
            }
            dataTask.resume()
        }*/

        return cell
    }
    

}
