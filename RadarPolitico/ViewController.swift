//
//  ViewController.swift
//  RadarPolitico
//
//  Created by Lucas de Brito on 07/01/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var tableArray1 = ["Dick Vigarista","Mutley"]
    var arrayFotos1 = ["dick_vigarista_01.jpg","mutley.jpeg"]
    var tableArray2 = ["Penelope Charmosa","Peter Perfeito"]
    var arrayFotos2 = ["penelope.png","peter perfeito.jpg"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var x = 0
        
        if section == 0{
            x = tableArray1.count
        }
        if section == 1{
            x = tableArray2.count
        }
        
        return x
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        if section == 0 {
            title = "Deputados Federais"
        }else{
            title = "Senadores"
        }
        
        return title
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        if indexPath.section == 0{
            cell.nomePolitico.text = tableArray1[indexPath.row]
            cell.fotoPolitico.image = UIImage(named:arrayFotos1[indexPath.row])
        
        }else {
            cell.nomePolitico.text = tableArray2[indexPath.row]
            cell.fotoPolitico.image = UIImage(named:arrayFotos2[indexPath.row])
        }
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height/2
        cell.fotoPolitico.layer.cornerRadius = cell.fotoPolitico.frame.height/2
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }


}

