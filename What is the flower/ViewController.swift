//
//  ViewController.swift
//  What is the flower
//
//  Created by Justyna Kowalkowska on 10/09/2020.
//  Copyright © 2020 Justyna Kowalkowska. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var flowerImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            flowerImage.image = userPickerImage
            
            guard let ciImage = CIImage(image: userPickerImage) else {
                fatalError("Could not convert to CIImage.")
            }
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func tappedCamera(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
}

