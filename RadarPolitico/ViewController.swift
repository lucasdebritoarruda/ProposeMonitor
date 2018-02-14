//
//  ViewController.swift
//  RadarPolitico
//
//  Created by Lucas de Brito on 07/01/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var controle = 0
    var deputados = [politico]()
    var senadores = [politico]()
    
    var switchStatesDeputados = [Bool]()
    var switchStatesSenadores = [Bool]()
    
    
    var teste = 0
    var cargo = false
    

        
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Parlamentar")
        
        request.returnsObjectsAsFaults = false
        
        do{
            
            let results = try context.fetch(request)
            
            if results.count > 0{
                
                controle = results.count
                
                for result in results as! [NSManagedObject]{
                    
                    let nome = result.value(forKey: "nome") as! String
                    let partido = result.value(forKey: "partido") as! String
                    let foto = result.value(forKey: "foto") as! String
                    let tableIndex = result.value(forKey: "tableIndex") as! Int16
                    let deputado = result.value(forKey: "deputado") as! Bool
                    
                    let p = politico(nome: nome, partido: partido, foto: foto, deputado: deputado, tableIndex: tableIndex)
                    
                    p.tableIndex = tableIndex
                    
                    if p.deputado{
                        
                        deputados.append(p)
                        
                        print("Deputado "+p.nome+" adcionado a lista de deputados")
                        
                    }else{
                        
                        senadores.append(p)
                        
                        print("Senador(a) "+p.nome+" adcionado a lista de senadores")
                        
                    }
                    
                }
                
            }
            
        }catch{
            
            print("Deu merda")
            
        }
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        deputados.removeAll()
        
        senadores.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Parlamentar")
        
        request.returnsObjectsAsFaults = false
        
        do{
            
            let results = try context.fetch(request)
            
            if results.count > 0{
                
                controle = results.count
                
                for result in results as! [NSManagedObject]{
                    
                    let nome = result.value(forKey: "nome") as! String
                    
                    let partido = result.value(forKey: "partido") as! String
                    
                    let foto = result.value(forKey: "foto") as! String
                    
                    let tableIndex = result.value(forKey: "tableIndex") as! Int16
                    
                    let deputado = result.value(forKey: "deputado") as! Bool
                    
                    let p = politico(nome: nome, partido: partido, foto: foto, deputado: deputado, tableIndex: tableIndex)
                    
                    p.tableIndex = tableIndex
                    
                    if p.deputado{
                        
                        deputados.append(p)
                        
                        print("Deputado "+p.nome+" adcionado a lista de deputados")
                        
                    }else{
                        
                        senadores.append(p)
                        
                        print("Senador(a) "+p.nome+" adcionado a lista de senadores")
                        
                    }
                    
                }
                
            }
            
        }catch{
            
            print("Deu merda")
            
        }
        
        self.tableView.reloadData()
        
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
                x = deputados.count
            }
            if section == 1{
                x = senadores.count
            }
            
            return x
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title = ""
        
        switch section {
        case 0:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0{
                title = "Deputados Federais"
                return title
            }
        case 1:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0{
                title = "Senadores"
                return title
            }
        default:
            return nil
        }
        
        return nil
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
                if indexPath.section == 0{
                    
                        cell.nomePolitico.text = deputados[indexPath.row].nome
                        cell.fotoPolitico.image = UIImage(named:deputados[indexPath.row].foto)
                    
                } else {
                    
                        cell.nomePolitico.text = senadores[indexPath.row].nome
                        cell.fotoPolitico.image = UIImage(named:senadores[indexPath.row].foto)
                    
                    }
        
                        cell.fotoPolitico.layer.cornerRadius = cell.fotoPolitico.frame.height/2
        
                return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        teste = indexPath.row
        if indexPath.section == 0{
            cargo = true
        }else{
            cargo = false
        }
        
        self.performSegue(withIdentifier: "politicosToPoliticoSelecionado", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "politicosToPoliticoSelecionado"{
            
            let barViewController = segue.destination as! PerfilTabBarViewController
            
            let politico = barViewController.viewControllers![0] as! PoliticoViewController
            
            let proposicoes = barViewController.viewControllers![1] as! ProposicoesTableViewController
            
            let frequencia = barViewController.viewControllers![2] as! FrequenciaViewController
            
            if cargo{
                
                politico.nome = deputados[teste].nome
                
                politico.imagem = deputados[teste].foto
                
            }else{
                
                politico.nome = senadores[teste].nome
                
                politico.imagem = senadores[teste].foto
                
            }
            
            proposicoes.teste = teste
            frequencia.teste = String(teste)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            if indexPath.section == 0 {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                let context = appDelegate.persistentContainer.viewContext
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Parlamentar")
                
                request.predicate = NSPredicate(format: "nome = %@", deputados[indexPath.row].nome)
                
                request.returnsObjectsAsFaults = false
                
                do{
                    
                    let results = try context.fetch(request)
                    
                    if results.count > 0{
                        
                        for result in results as! [NSManagedObject]{
                            
                            context.delete(result)
                            
                            do{
                                
                                try context.save()
                                print("Deputado " + deputados[indexPath.row].nome + " deletado do Core Data")
                                
                            }catch{
                                
                                print("Error")
                                
                            }
                            
                        }
                        
                    }
                    
                }catch{
                    
                    print("Deu merda")
                    
                }
                
                
                let x = UserDefaults.standard.array(forKey: "switchStatesDeputados")
                
                if let switchStateAUX = x as? [Bool] {
                    
                    switchStatesDeputados = switchStateAUX
                    
                }
                
                switchStatesDeputados[Int(deputados[indexPath.row].tableIndex)] = false
                
                UserDefaults.standard.set(switchStatesDeputados, forKey: "switchStatesDeputados")
                
                deputados.remove(at: indexPath.row)
                
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                
            }else{
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                let context = appDelegate.persistentContainer.viewContext
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Parlamentar")
                
                request.predicate = NSPredicate(format: "nome = %@", senadores[indexPath.row].nome)
                
                request.returnsObjectsAsFaults = false
                
                do{
                    
                    let results = try context.fetch(request)
                    
                    if results.count > 0{
                        
                        for result in results as! [NSManagedObject]{
                            
                            context.delete(result)
                            
                            do{
                                
                                try context.save()
                                print("Deputado " + senadores[indexPath.row].nome + " deletado do Core Data")
                                
                            }catch{
                                
                                print("Error")
                                
                            }
                            
                        }
                        
                    }
                    
                }catch{
                    
                    print("Deu merda")
                    
                }
                
                
                
                let x = UserDefaults.standard.array(forKey: "switchStatesSenadores")
                
                if let switchStateAUX = x as? [Bool] {
                    
                    switchStatesSenadores = switchStateAUX
                    
                }
                
                switchStatesSenadores[Int(senadores[indexPath.row].tableIndex)] = false
                
                UserDefaults.standard.set(switchStatesSenadores, forKey: "switchStatesSenadores")
                
                senadores.remove(at: indexPath.row)
                
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)

                
            }
            
        }
        
    }
    
}

