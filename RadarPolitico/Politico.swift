//
//  Politico.swift
//  RadarPolitico
//
//  Created by Lucas de Brito on 15/01/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class Politico{
    var nome: String
    var partido: String
    var foto: String
    var deputado: Bool
    
    init(nome: String, partido: String, foto: String, deputado: Bool) {
        
        self.nome = nome
        
        self.partido = partido
        
        self.foto = foto
        
        self.deputado = deputado
        
    }
    
}
