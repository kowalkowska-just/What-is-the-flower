//
//  ViewController.swift
//  What is the flower
//
//  Created by Justyna Kowalkowska on 10/09/2020.
//  Copyright © 2020 Justyna Kowalkowska. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var flowerImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            flowerImage.image = userPickerImage
            
            guard let convertedUIImage = CIImage(image: userPickerImage) else {
                fatalError("Could not convert to CIImage.")
            }
            
            detect(flowerImage: convertedUIImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(flowerImage: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            let classification = request.results?.first as? VNClassificationObservation
        
            self.navigationItem.title = classification?.identifier.capitalized
            
            
            
//            if let firstResult = results.first {
//                if firstResult.identifier.contains("hotdog") {
//                    self.navigationItem.title = "Hotdog!"
//                } else {
//                    self.navigationItem.title = "Not Hotdog!"
//                }
//            }
        }
            
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func tappedCamera(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
}

