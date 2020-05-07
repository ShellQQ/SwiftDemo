//
//  CameraViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/6.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    var camera:CameraPreviewView!
    
    private var isRecording: Bool = false
    private let buttonImage = UIColor.red.asImage(size: CGSize(width: 68, height: 68))?.isRoundCorner(radius: 34, corners: [.allCorners])
    
    @IBOutlet weak var cameraView: UIView!
    
    // 切換前後相機
    @IBAction func switchCamera(_ sender: UIButton) {
        print(camera.inputDevice)
        let device = camera.inputDevice
        
        switch device {
        case .front:
            camera.changeCameraPosition(input: .back)
        case .back:
            camera.changeCameraPosition(input: .front)
        default:
            print("do nothing")
        }
    }
    
    // 切換閃光燈模式
    @IBAction func switchFlash(_ sender: UIButton) {
        
        let flashMode = camera.changeFlashMode()
        
        switch flashMode {
        case .auto:
            sender.setImage(UIImage(named: "flash_auto"), for: .normal)
        case .off:
            sender.setImage(UIImage(named: "flash_off"), for: .normal)
        case .on:
            sender.setImage(UIImage(named: "flash_on"), for: .normal)
        @unknown default:
            return
        }
    }
    
    // 切換拍照或錄影模式
    @IBAction func switchToVideo(_ sender: UIButton) {
        let recordMode = camera.changeRecordMode()
       
        switch recordMode {
        case .photo:
            sender.setImage(UIImage(named: "video"), for: .normal)
        case .quicktime:
            sender.setImage(UIImage(named: "picture_portrait"), for: .normal)
        }
    }

    // 開始拍照 or 錄影
    @IBAction func startRecord(_ sender: UIButton) {
        let outputMode = camera.recordMode
        
        switch outputMode {
        case .photo:
            camera.takePhotoAndSave()
        case .quicktime:
            isRecording = !isRecording
            if isRecording {
                print("start record")
                
                sender.setImage(buttonImage, for: .normal)
                camera.startRecordingQuickTimeMovie()
            }
            else {
                print("stop record")
                sender.setImage(UIImage(named: "record"), for: .normal)
                camera.stopRecordingQuickTimeMovie()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        camera = CameraPreviewView()
        cameraView.addSubview(camera)
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        camera.prepareCamera()
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
