//
//  InitialPhotoViewController.swift
//  photoEdit
//
//  Created by Alisha on 2021/6/15.
//

import UIKit

class InitialPhotoViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    

    //打開Library之後，再點選照片之後的動作
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.originalImage] as? UIImage
    
        //回到之前的頁面
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openLibrary()
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        openLibrary()
        
    }
    
    //打開圖庫
    func openLibrary() {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }

    @IBSegueAction func showEditPhoto(_ coder: NSCoder) -> EditPhotoViewController? {
        let photo = photoImageView.image!
        let vc =  EditPhotoViewController(coder: coder)
        vc?.photoImg = PhotoSetting(photo: photo)
        return vc
    }    
}





















