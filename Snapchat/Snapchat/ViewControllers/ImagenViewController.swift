//
//  ImagenViewController.swift
//  Snapchat
//
//  Created by Leon on 2/11/18.
//  Copyright © 2018 Leon. All rights reserved.
//

import UIKit
import Firebase
class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var fotoView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        elegirContactoBoton.isEnabled = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        elegirContactoBoton.isEnabled = true
        fotoView.image = image
        fotoView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoBoton.isEnabled = false
        let imagesFolder = Storage.storage().reference().child("imagenes")
        let imageData = fotoView.image!.jpegData(compressionQuality: 0.1)
        imagesFolder.child("\(imagenID).jpg").putData(imageData!, metadata: nil, completion:{(metadata,error) in
            print("Intentando subir imagen")
            if error != nil{
                print("ERROR")
                print("Ocurrió un error \(String(describing: error))")
            }else{
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: metadata?.path)
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC =  segue.destination as! ElegirUsuarioViewController
        siguienteVC.imagenURL = sender as! String
        siguienteVC.descrip = descripcionTextField.text!
        siguienteVC.imagenID = imagenID
    }
}
