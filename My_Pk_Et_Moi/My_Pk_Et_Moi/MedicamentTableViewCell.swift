//
//  MedicamentTableViewCell.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 13/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class MedicamentTableViewCell: UITableViewCell {

    @IBOutlet weak var medicNameLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
