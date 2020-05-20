//
//  addNewShellTableViewController.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/14.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class addNewShellTableViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var commonNameTextField: RoundedTextField! {
        didSet {
            commonNameTextField.tag = 1
            commonNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var scientificNameTextField: RoundedTextField! {
        didSet {
            scientificNameTextField.tag = 2
            scientificNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var familyCNTextField: RoundedTextField! {
        didSet {
            familyCNTextField.tag = 3
            familyCNTextField.delegate = self
        }
    }
    @IBOutlet weak var familyENTextField: RoundedTextField! {
        didSet {
            familyENTextField.tag = 4
            familyENTextField.delegate = self
        }
    }
    @IBOutlet weak var distributedTextField: RoundedTextField! {
        didSet {
            distributedTextField.tag = 5
            distributedTextField.delegate = self
        }
    }
    @IBOutlet weak var quantityTextField: RoundedTextField! {
        didSet {
            quantityTextField.tag = 6
            quantityTextField.delegate = self
        }
    }
    @IBOutlet weak var sizeTextField: RoundedTextField! {
        didSet {
            sizeTextField.tag = 7
            sizeTextField.delegate = self
        }
    }
    
    @IBAction func unwindBack(segue: UIStoryboardSegue) {
        print("unwind segue")
        
        
    }
    
    @IBAction func saveButtonTap(_ sender: UIBarButtonItem) {
        if let controllers = navigationController?.viewControllers, let preController = controllers[controllers.count - 2] as? CoreDataDemoViewController{
            
            print("pre controller: \(preController)")

            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                
                let shell = Shell(context: appDelegate.persistentContainer.viewContext)
                
                shell.commonName = commonNameTextField.text
                shell.scientificName = scientificNameTextField.text
                shell.family_cn = familyCNTextField.text
                shell.family_en = familyENTextField.text
                shell.distributed = distributedTextField.text
                shell.quantity = Int16(quantityTextField.text!) ?? 1
                shell.size = Float(sizeTextField.text!) ?? 0
                if let shellImage = photoImageView.image {
                    shell.photos = shellImage.pngData() as NSData?
                }
                
                appDelegate.saveContext()
            }
            
            preController.reloadData()
            //self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == 0 else { return }
        
        let photoSourceRequestController = UIAlertController(title: "", message: "選擇照片來源", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "相機", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        let photoLibraryAction = UIAlertAction(title: "相片膠卷", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        
        // ipad
        if let popoverController = photoSourceRequestController.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        present(photoSourceRequestController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
            
            photoImageView.translatesAutoresizingMaskIntoConstraints = false
            photoImageView.topAnchor.constraint(equalTo: photoImageView.superview!.topAnchor).isActive = true
            photoImageView.leadingAnchor.constraint(equalTo: photoImageView.superview!.leadingAnchor).isActive = true
            photoImageView.trailingAnchor.constraint(equalTo: photoImageView.superview!.trailingAnchor).isActive = true
            photoImageView.bottomAnchor.constraint(equalTo: photoImageView.superview!.bottomAnchor).isActive = true
        }
        
        commonNameTextField.becomeFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
