//
//  MedecinTableViewCell.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 26/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class MedecinTableViewCell: UITableViewCell {

    @IBOutlet weak var nomMedLabel: UILabel!
    @IBOutlet weak var specialiteLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
