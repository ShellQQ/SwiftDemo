//
//  FileManagerViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/4/20.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class FileManagerViewController: UIViewController, URLSessionDownloadDelegate {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var outputText: UITextView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBAction func onSaveButtonDown(_ sender: UIButton) {
        saveImage()
    }
    
    
    private let imageURL = "http://www.zoo.gov.tw/iTAP/03_Animals/PandaHouse/Panda_Pic01.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        downloadImage(dataURL: imageURL)
    }
    
    func downloadImage(dataURL: String) {
        guard let url = URL(string: dataURL) else {
            print("image url illegle")
            myImage.image = UIImage(named: "noImage")
            
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
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) * 100
        progressLabel.text = "\(progress) %"
        print("下載進度 \(progress)")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let data = try? Data(contentsOf: location) {
            myImage.image = UIImage(data: data)
            saveButton.isEnabled = true
            //progressLabel.isHidden = true
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
        
    func saveImage() {
        if let data = myImage.image?.jpegData(compressionQuality: 0.8) {
            //let filename = getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).jpeg")
            let filename = getDocumentsDirectory().appendingPathComponent("panda.jpeg")
            print("filename:\(filename)")
            do {
                try data.write(to: filename)
                allFilesInDocument()
            } catch {
                print("存擋失敗")
            }
        }
    }
    
    func allFilesInDocument() {
        var filesText: String = ""
        
        let fm = FileManager.default
        
        do {
            let files = try fm.contentsOfDirectory(atPath: NSHomeDirectory())
            //let files = try fm.contentsOfDirectory(atPath: getDocumentsDirectory().absoluteString)
            print(NSHomeDirectory())
            print("files:\(files)")
            for file in files {
                filesText += (file + "\n")
            }
        } catch {
            print("讀取documents檔案失敗")
        }
        outputText.text = filesText
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0]
    }
    
}
