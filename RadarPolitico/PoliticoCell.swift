//
//  PoliticoCell.swift
//  RadarPolitico
//
//  Created by Lucas de Brito on 13/01/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class PoliticoCell: UITableViewCell {

    @IBOutlet weak var nomePoliticoLbl: UILabel!
    @IBOutlet weak var nomePartidoLbl: UILabel!
    @IBOutlet weak var seguindoSwitchOutlet: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
