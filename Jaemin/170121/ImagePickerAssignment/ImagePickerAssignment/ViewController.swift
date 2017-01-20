//
//  ViewController.swift
//  ImagePickerAssignment
//
//  Created by LimJaemin on 2017. 1. 19..
//  Copyright © 2017년 LimJaemin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.openAlertView))
        
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    func openAlertView() { // imageView를 tap하면 alertView가 나타난다
        let controller = UIAlertController(title: "사진 소스 선택", message: "사진을 가져올 소스를 선택해 주세요",
                                           preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "라이브러리", style: UIAlertActionStyle.default) { action in
            self.pickImageFromPhotoLibrary()
        }
        let photoAlbumAction = UIAlertAction(title: "사진앨범", style: UIAlertActionStyle.default) { action in
            self.pickImageFromPhotoAlbum()
        }
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel) { action in
            self.dismiss(animated: true, completion: nil)
        }
        
        controller.addAction(photoLibraryAction)
        controller.addAction(photoAlbumAction)
        controller.addAction(cancelAction)
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func pickImageFromPhotoLibrary() {
        let picker = UIImagePickerController()
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        // delegate 지정
        picker.delegate = self
        
        self.present(picker, animated: false)
    }
    
    func pickImageFromPhotoAlbum() {
        let picker = UIImagePickerController()
        
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = true
        
        // delegate 지정
        picker.delegate = self
        
        self.present(picker, animated: false)
    }
    
    // ImagePicker에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false) {
            // 알림창
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    // ImagePicker에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: false) { () in
            // 선택된 이미지를 imageView에 표시
            let image = info[UIImagePickerControllerEditedImage] as? UIImage
            self.imageView.image = image
        }
    }
    
}

