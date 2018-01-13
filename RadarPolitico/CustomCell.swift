//
//  CustomCell.swift
//  RadarPolitico
//
//  Created by Lucas de Brito on 07/01/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var nomePolitico: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var fotoPolitico: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
