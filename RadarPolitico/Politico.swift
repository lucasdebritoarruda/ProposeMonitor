//
//  Politico.swift
//  RadarPolitico
//
//  Created by Lucas de Brito on 15/01/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class politico{
    
    var nome: String
    var partido: String
    var foto: String
    var deputado: Bool
    var tableIndex: Int16
    
    init(nome: String, partido: String, foto: String, deputado: Bool, tableIndex: Int16) {
        
        self.nome = nome
        
        self.partido = partido
        
        self.foto = foto
        
        self.deputado = deputado
        
        self.tableIndex = tableIndex

    }
    
}
