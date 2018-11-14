//
//  VerSnapViewController.swift
//  Snapchat
//
//  Created by Leon on 7/11/18.
//  Copyright © 2018 Leon. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
class VerSnapViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var snap = Snap()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text? = snap.descrip
        print("IMAGE URL:::"+snap.imagenURL)
        
        let ref = Storage.storage().reference().child(snap.imagenURL)
        ref.downloadURL(completion: { (url, error) in
            if let error = error{
                print("An error ocurred \(error)")
            }else{
                self.imageView.sd_setImage(with: URL(string: url!.absoluteString))
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("usuarios").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.id).removeValue()
        Storage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete { (error) in            
            print("Se eliminò la imagen correctamente")
        }
    }

}
