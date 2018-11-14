//
//  ElegirUsuarioViewController.swift
//  Snapchat
//
//  Created by Leon on 2/11/18.
//  Copyright © 2018 Leon. All rights reserved.
//

import UIKit
import Firebase
class ElegirUsuarioViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var usuarios: [Usuario] = []
    var imagenURL = ""
    var descrip = ""
    var imagenID = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = usuarios[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email!,"descripcion":descrip,"imagenURL":imagenURL,"imagenID":imagenID]
        Database.database().reference().child("usuarios").child(usuario.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(snapshot) in
           // print(snapshot)
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
        })
    }
    

}
