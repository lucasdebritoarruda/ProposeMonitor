    //
    //  CargoSelecionadoTableViewController.swift
    //  RadarPolitico
    //
    //  Created by Lucas de Brito on 13/01/2018.
    //  Copyright © 2018 Lucas de Brito. All rights reserved.
    //

    import UIKit
    import CoreData

    class CargoSelecionadoTableViewController: UITableViewController {
        
        var cargo: Int?
        var switchStatesDeputados = [Bool]()
        var switchStatesSenadores = [Bool]()
        var alteradaDeputados = false
        var alteradaSenadores = false
        
        var politico1 = politico(nome: "Dick Vigarista", partido: "PMDB", foto: "dick_vigarista_01.jpg", deputado: true, tableIndex: 0)
        var politico2 = politico(nome: "Salsicha", partido: "PSOL", foto: "DQ.jpg", deputado: true, tableIndex: 0)
        var politico3 = politico(nome: "Fred", partido: "PSDB", foto: "DQ.jpg", deputado: true, tableIndex: 0)
        var politico4 = politico(nome: "Scooby-Doo", partido: "PSOL", foto: "DQ.jpg", deputado: true, tableIndex: 0)
        var politico5 = politico(nome: "Barney", partido: "PT", foto: "DQ.jpg", deputado: true, tableIndex: 0)
        var politico6 = politico(nome: "Penelope Charmosa", partido: "PSDB", foto: "penelope.png", deputado: false, tableIndex: 0)
        var politico7 = politico(nome: "Peter Perfeito", partido: "PSDB", foto: "peter perfeito.jpg", deputado: false, tableIndex: 0)
        var politico8 = politico(nome: "Mutley", partido: "PMDB", foto: "mutley.jpeg", deputado: false, tableIndex: 0)
        var politico9 = politico(nome: "Velma", partido: "PSOL", foto: "DQ.jpg", deputado: false, tableIndex: 0)
        var politico10 = politico(nome: "Capitão Caverna", partido: "PSTU", foto: "DQ.jpg", deputado: false, tableIndex: 0)
        
        var politicos = [politico]() // LISTA DE TODOS OS DEPUTADOS
        
        var politicos2 = [politico]() // LISTA DE TODOS OS SENADORES
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.tableFooterView = UIView()
            
            tableView.setEditing(false, animated: true)
            
            politicos.append(politico1)
            politicos.append(politico2)
            politicos.append(politico3)
            politicos.append(politico4)
            politicos.append(politico5)
            politicos2.append(politico6)
            politicos2.append(politico7)
            politicos2.append(politico8)
            politicos2.append(politico9)
            politicos2.append(politico10)
            
            if cargo == 0{
                
                let x = UserDefaults.standard.value(forKey: "alteradaDeputados")
                
                if let alteradaAUX = x as? Bool{
                    
                    alteradaDeputados = alteradaAUX
                    
                }
                
            } else {
                
                let x = UserDefaults.standard.value(forKey: "alteradaSenadores")
                
                if let alteradaAUX = x as? Bool{
                    
                    alteradaSenadores = alteradaAUX
                    
                }
                
            }
            
            
        
            
        }
        
       

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            
            return 1
            
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            
            if cargo == 0{
                
                return politicos.count
                
            }else{
                
                return politicos2.count
                
            }
            
            
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PoliticoCelula", for: indexPath) as! PoliticoCell
            
            if cargo == 0 {
                
                cell.nomePoliticoLbl.text = politicos[indexPath.row].nome
                
                cell.nomePartidoLbl.text = politicos[indexPath.row].partido
                
                if alteradaDeputados{ //EXECUTA QUANDO TABELA DE DEPUTADOS JA FOI ALTERADA
                    
                    let x = UserDefaults.standard.array(forKey: "switchStatesDeputados")
                    
                    if let switchStatesAUX = x as? [Bool]{
                        
                        switchStatesDeputados = switchStatesAUX
                        
                        if switchStatesDeputados[indexPath.row]{
                            
                            cell.seguindoSwitchOutlet.isOn = true
                            
                        }
                        
                    }
                    
                }else{ //EXECUTA QUANDO TABELA DE DEPUTADOS AINDA NÃO FOI ALTERADA
                    
                    switchStatesDeputados.append(false)
                    
                }
                
            }else{
                
                    cell.nomePoliticoLbl.text = politicos2[indexPath.row].nome
                
                    cell.nomePartidoLbl.text = politicos2[indexPath.row].partido
                
                    if alteradaSenadores{
                    
                    let x = UserDefaults.standard.array(forKey: "switchStatesSenadores")
                    
                    if let switchStatesAUX = x as? [Bool]{
                        
                        switchStatesSenadores = switchStatesAUX
                        
                        if switchStatesSenadores[indexPath.row]{
                            
                            cell.seguindoSwitchOutlet.isOn = true
                            
                        }
                        
                    }
                    
                    } else{
                    
                        switchStatesSenadores.append(false)
                    
                    }
                
            }
            
            cell.seguindoSwitchOutlet.tag = indexPath.row
            
            cell.seguindoSwitchOutlet.addTarget(self, action: #selector(seguindo), for: UIControlEvents.valueChanged)
            
            return cell
            
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 90
            
        }
        
            @objc func seguindo(sender:UISwitch){
                if cargo == 0{
                    
                   alteradaDeputados = true
                    
                    if sender.isOn{
                        
                        //SALVANDO DEPUTADOS NO CORE DATA - INICIO
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        let context = appDelegate.persistentContainer.viewContext
                        
                        let newParlamentar = NSEntityDescription.insertNewObject(forEntityName: "Parlamentar", into: context)
                        
                        newParlamentar.setValue(politicos[sender.tag].nome, forKey: "nome")
                        newParlamentar.setValue(politicos[sender.tag].partido, forKey: "partido")
                        newParlamentar.setValue(politicos[sender.tag].foto, forKey: "foto")
                        newParlamentar.setValue(politicos[sender.tag].deputado, forKey: "deputado")
                        newParlamentar.setValue(sender.tag, forKey: "tableIndex")
                        
                        do{
                            
                            try context.save()
                            print("Deputado " + politicos[sender.tag].nome + " salvo no Core Data")
                            
                        }catch{
                            
                            print("Error")
                            
                        }
                        //SALVANDO DEPUTADOS NO CORE DATA - FIM
                        
                        print(sender.tag)
                        switchStatesDeputados[sender.tag] = true
                        
                        
                    }else{
                        
                        // DELETANDO DEPUTADOS NO CORE DATA - INICIO
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        let context = appDelegate.persistentContainer.viewContext
                        
                        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Parlamentar")
                        
                        request.predicate = NSPredicate(format: "nome = %@", politicos[sender.tag].nome)
                        
                        request.returnsObjectsAsFaults = false
                        
                        do{
                            
                            let results = try context.fetch(request)
                            
                            if results.count > 0{
                                
                                for result in results as! [NSManagedObject]{
                                    
                                    context.delete(result)
                                    
                                    do{
                                        
                                        try context.save()
                                        print("Deputado " + politicos[sender.tag].nome + " deletado do Core Data")
                                        
                                    }catch{
                                        
                                        print("Error")
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }catch{
                            
                            print("Deu merda")
                            
                        }
                        
                        // DELETANDO DEPUTADOS NO CORE DATA - FIM
                        
                        switchStatesDeputados[sender.tag] = false
                        
                        
                    }
                    
                    UserDefaults.standard.set(alteradaDeputados, forKey: "alteradaDeputados")
                    UserDefaults.standard.set(switchStatesDeputados, forKey: "switchStatesDeputados")
                    
                }else{
                    
                    alteradaSenadores = true
                    
                    if sender.isOn{
                        
                        //SALVANDO SENADORES NO CORE DATA - INICIO
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        let context = appDelegate.persistentContainer.viewContext
                        
                        let newParlamentar = NSEntityDescription.insertNewObject(forEntityName: "Parlamentar", into: context)
                        
                        newParlamentar.setValue(politicos2[sender.tag].nome, forKey: "nome")
                        newParlamentar.setValue(politicos2[sender.tag].partido, forKey: "partido")
                        newParlamentar.setValue(politicos2[sender.tag].foto, forKey: "foto")
                        newParlamentar.setValue(politicos2[sender.tag].deputado, forKey: "deputado")
                        newParlamentar.setValue(sender.tag, forKey: "tableIndex")
                        
                        do{
                            
                            try context.save()
                            print("Senador " + politicos2[sender.tag].nome + " salvo no Core Data")
                            
                        }catch{
                            
                            print("Error")
                            
                        }
                        //SALVANDO SENADORES NO CORE DATA - FIM
                        
                        print(sender.tag)
                        switchStatesSenadores[sender.tag] = true
                        
                    }else{
                        
                        //DELETANDO SENADORES DO CORE DATA - INICIO
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        let context = appDelegate.persistentContainer.viewContext
                        
                        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Parlamentar")
                        
                        request.predicate = NSPredicate(format: "nome = %@", politicos2[sender.tag].nome)
                        
                        request.returnsObjectsAsFaults = false
                        
                        do{
                            
                            let results = try context.fetch(request)
                            
                            if results.count > 0{
                                
                                for result in results as! [NSManagedObject]{
                                    
                                    context.delete(result)
                                    
                                    do{
                                        
                                        try context.save()
                                        print("Senador " + politicos2[sender.tag].nome + " deletado do Core Data")
                                        
                                    }catch{
                                        
                                        print("Error")
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }catch{
                            
                            print("Deu merda")
                            
                        }
                        
                        //DELETANDO SENADORES DO CORE DATA - FIM
                        
                        switchStatesSenadores[sender.tag] = false
                        
                    }
                    
                    UserDefaults.standard.set(alteradaSenadores, forKey: "alteradaSenadores")
                    UserDefaults.standard.set(switchStatesSenadores, forKey: "switchStatesSenadores")
                    
                }
                
                
                
            }
     

        /*
        // Override to support conditional editing of the table view.
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        */

        /*
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        */

        /*
        // Override to support rearranging the table view.
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        }
        */

        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the item to be re-orderable.
            return true
        }
        */

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
        */

    }
