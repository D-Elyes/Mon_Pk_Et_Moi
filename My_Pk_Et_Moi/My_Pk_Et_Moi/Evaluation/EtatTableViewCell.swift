//
//  EtatTableViewCell.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 22/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EtatTableViewCell: UITableViewCell {

    @IBOutlet weak var heureLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!
    @IBOutlet weak var evenementLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
