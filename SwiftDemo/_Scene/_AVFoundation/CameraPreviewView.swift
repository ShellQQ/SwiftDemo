//
//  CameraPreviewView.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/6.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewView: UIView {
    
    // 建立Capture Session
    private var captureSession = AVCaptureSession()
    var inputDevice : CameraInputDevice = .back
    // 預覽顯示圖層
    private var previewLayer: AVCaptureVideoPreviewLayer?
    // 閃光燈模式
    private var flashMode = AVCaptureDevice.FlashMode.off
    // 拍照模式或是影片模式
    var recordMode: CameraRecordMode = .photo

    // 前置廣角鏡頭
    private var frontWildAngleCamera: AVCaptureDeviceInput?
    // 後置廣角鏡頭
    private var backWildAngleCamera: AVCaptureDeviceInput?
    // 後置望遠鏡頭
    private var backTelephotoCamera: AVCaptureDeviceInput?
    // 後置雙鏡頭
    private var backDualCamera: AVCaptureDeviceInput?
    // 麥克風
    private var microphone: AVCaptureDeviceInput?
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCamera() {
        // 1. 建立一個 Capture Session
        // 2. 取得與設定必要的 Capture Devices
        getAllCamera()
        getMicrophone()
        settingPreviewLayer()
        // 3. 在 Capture Device 上建立 Inputs
        cameraStart()
        // 4. 設定一個 Photo Output 物件來處理擷取到的影像，預設為照片
        // 照片: setPhotoOutput()
        // QuickTime影片: setQuickTimeOutput()
        setPhotoOutput()
        
    }
    
    // 取得所有鏡頭
    func getAllCamera() {
        let cameras = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInDualCamera], mediaType: .video, position: .unspecified).devices
        
        for camera in cameras {
            let inputDevice = try! AVCaptureDeviceInput(device: camera)
            
            if camera.deviceType == .builtInWideAngleCamera, camera.position == .front {
                frontWildAngleCamera = inputDevice
                print("前置廣角鏡頭")
            }
            
            if camera.deviceType == .builtInWideAngleCamera, camera.position == .back {
                backWildAngleCamera = inputDevice
                print("後置廣角鏡頭")
            }
            
            if camera.deviceType == .builtInTelephotoCamera {
                backTelephotoCamera = inputDevice
                print("後置望遠鏡頭")
            }
            
            if camera.deviceType == .builtInDualCamera {
                backDualCamera = inputDevice
                print("後置雙鏡頭")
            }
        }
    }
    
    // 取得麥克風
    func getMicrophone() {
        if let mic = AVCaptureDevice.default(for: .audio) {
            microphone = try! AVCaptureDeviceInput(device: mic)
            print("麥克風")
        }
    }
    
    // 取得預設照相機 （後製置廣角鏡頭）
    func getCamera() {
        if let camera = AVCaptureDevice.default(for: .video) {
            backWildAngleCamera = try! AVCaptureDeviceInput(device: camera)
        }
    }
  
    // 設定預覽畫面圖層
    func settingPreviewLayer(){
        let previewLayer = AVCaptureVideoPreviewLayer()
        
        previewLayer.frame = self.superview!.bounds
        previewLayer.session = captureSession
        previewLayer.videoGravity = .resizeAspectFill
        //previewLayer?.connection?.videoOrientation = .portrait     //  設定畫面直相
        
        self.layer.addSublayer(previewLayer)
    }
    
    // 讓相機資料開始流入
    func cameraStart(input device: CameraInputDevice = .back){
        addCameraInput(input: device)
        
        captureSession.startRunning()
    }
    
    // 更改前後相機
    func changeCameraPosition(input device: CameraInputDevice) {
        // 開始修改 session
        captureSession.beginConfiguration()
        
        // 移除現有 input
        captureSession.removeInput(captureSession.inputs.last!)
        // 新的 input
        addCameraInput(input: device)
        
        // 確認修改 session
        captureSession.commitConfiguration()
    }
    
    // 更改儲存模式
    func changeRecordMode() -> CameraRecordMode{
        recordMode = CameraRecordMode(rawValue: (recordMode.rawValue + 1) % 2) ?? CameraRecordMode.photo
        
        switch recordMode {
        case .photo:
            print("change to picture")
            changeToPhotoMode()
        case .quicktime:
            print("change to video")
            changeToQuickTimeMode()
        }
        
        print(captureSession.outputs)
        return recordMode
    }
    
    // 更改相機模式為影片
    func changeToQuickTimeMode() {
        // 開始修改 session
        captureSession.beginConfiguration()

        if inputDevice != .back {
            captureSession.removeInput(captureSession.inputs.last!)
            addCameraInput(input: .back)
        }
        
        captureSession.removeOutput(captureSession.outputs.last!)
        
        addMicrophoneInput()
        setQuickTimeOutput()
        
        // 確認修改 session
        captureSession.commitConfiguration()
    }
    
    // 更改相機模式為照片
    func changeToPhotoMode() {
        // 開始修改 session
        captureSession.beginConfiguration()
        
        captureSession.removeOutput(captureSession.outputs.last!)
        
        removeMicrophoneInput()
        setPhotoOutput()
        
        // 確認修改 session
        captureSession.commitConfiguration()
        
        
    }
    
    func addCameraInput(input device: CameraInputDevice) {
        switch device {
        case .front:
            captureSession.addInput(frontWildAngleCamera!)
        case .back:
            captureSession.addInput(backWildAngleCamera!)
        case .tele:
            captureSession.addInput(backTelephotoCamera!)
        case .dual:
            captureSession.addInput(backDualCamera!)
        default:
            return
        //case .mike:
            //captureSession.addInput(microphone!)
        }
        
        inputDevice = device
    }
    
    func addMicrophoneInput() {
        captureSession.addInput(microphone!)
    }
    
    func removeMicrophoneInput() {
        captureSession.removeInput(microphone!)
    }
    
    // 設定照片輸出格式及解析度
    func setPhotoOutput() {
        captureSession.sessionPreset = .photo
        captureSession.addOutput(AVCapturePhotoOutput())
    }
    
    // 設定QuickTime影片輸出格式及解析度
    func setQuickTimeOutput() {
        captureSession.sessionPreset = .hd1280x720
        captureSession.addOutput(AVCaptureMovieFileOutput())
    }
    
    // 改變閃光燈模式
    func changeFlashMode() -> AVCaptureDevice.FlashMode {
        flashMode = AVCaptureDevice.FlashMode(rawValue: (flashMode.rawValue + 1) % 3) ?? AVCaptureDevice.FlashMode.off
        print("flash mode: \(flashMode.rawValue)")
        
        return flashMode
    }

    /*func switchFrontBackCamera(input device: CameraInputDevice){
        captureSession.beginConfiguration()
        
        captureSession.removeInput(captureSession.inputs.last!)
        if device == .front {
            captureSession.addInput(frontWildAngleCamera!)
        }
        else if device == .back {
            captureSession.addInput(backWildAngleCamera!)
        }
        
        captureSession.commitConfiguration()
    }*/
    
    func takePhotoAndSave() {
        let setting = AVCapturePhotoSettings()
        setting.flashMode = flashMode
        
        let output = captureSession.outputs.first! as! AVCapturePhotoOutput
        output.capturePhoto(with: setting, delegate: self)
    }
    
    // 開始錄製影片
    func startRecordingQuickTimeMovie() {
        // 影片暫存路徑
        let url = URL(fileURLWithPath: NSTemporaryDirectory() + "output.mov")
        // 開始錄影
        let output = captureSession.outputs.first! as! AVCaptureMovieFileOutput
        output.startRecording(to: url, recordingDelegate: self)
    }
    
    // 停止錄製影片
    func stopRecordingQuickTimeMovie() {
        let output = captureSession.outputs.first! as! AVCaptureMovieFileOutput
        output.stopRecording()
    }
    
}

extension CameraPreviewView: AVCapturePhotoCaptureDelegate, AVCaptureFileOutputRecordingDelegate {
    
    // 實作 AVCapturePhotoCaptureDelegate
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let image = UIImage(data: photo.fileDataRepresentation()!)
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }

    // 實作 AVCaptureFileOutputRecordingDelegate，stopRecoreing() 呼叫後執行，將暫存資料複製到相片膠卷，複製完後將暫存影片刪除
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(outputFileURL.path) {
            UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, self, #selector(movieSaveComplete(_: error: contextInfo:)), nil)
        }
    }
    
    // 影片存擋完成後刪除暫存檔
    @objc func movieSaveComplete(_ videoPath: String, error: Error?, contextInfo: Any?) {
        do {
            let fm = FileManager.default
            try fm.removeItem(atPath: videoPath)
        } catch {
            print(error)
        }
    }
}

enum CameraInputDevice {
    case front
    case back
    case tele
    case dual
    case mike
}

enum CameraRecordMode: Int {
    case photo = 0
    case quicktime = 1
}
