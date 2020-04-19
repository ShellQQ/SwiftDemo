//
//  ZooTableViewCell.swift
//  SwiftDemo
//
//  Created by Apple on 2020/4/11.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class ZooTableViewCell: UITableViewCell, URLSessionDownloadDelegate {

    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalClass: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        animalImage.roundAllCorners(cornerRadius: 35)
        animalImage.image = UIImage(named: "noImage")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //parametersView.removeAllSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 使用URLSessionDataTask 讀取資料，將讀取完成得資料放在 data 變數中(不會儲存)
    func getAnimalImage(dataURL: String) {
        print("\(animalName.text) url")
        print(dataURL)
        guard let url = URL(string: dataURL) else {
            print("image url illegle")
            animalImage.image = UIImage(named: "noImage")
            return
         }
        
        // 使用預設建立session (default：在硬碟中儲存快取資料)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        
        // URLSessionDataTask 讀取資料，將讀取完成得資料放在 data (不會儲存)
        let dataTask = session.downloadTask(with: url)
        dataTask.resume()
    }
    
    // 取得目前下載進度，只有當App在前景時才會呼叫
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) * 100
        //print("\(animalName.text) 下載進度: \(progress)")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //print("\(animalName.text)下載完成")
        print(downloadTask.countOfBytesExpectedToReceive)
        if let data = try? Data(contentsOf: location) {
            animalImage.image = UIImage(data: data)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil {
            //print("\(animalName.text)圖片下載成功")
        }
        else {
            //print("\(animalName.text)圖片下載失敗")
        }
    }

}
