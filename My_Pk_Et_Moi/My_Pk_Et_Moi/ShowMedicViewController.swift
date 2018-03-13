//
//  ShowMedicViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 13/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class ShowMedicViewController: UIViewController {

    @IBOutlet weak var nomMedicLabel: UILabel!
    
    @IBOutlet weak var doseMedicLabel: UILabel!
    
    @IBOutlet weak var dateStartLabel: UILabel!
    
    @IBOutlet weak var dateEndLabel: UILabel!
    
    
    @IBOutlet weak var numberPerDayLabel: UILabel!
    
    
    @IBOutlet weak var numberPerWeekLabel: UILabel!
    
    var medicament : Medicament? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if a medicament exist then display it
        if let amedicament = self.medicament
        {
            self.nomMedicLabel.text = amedicament.nomMedicament
            self.doseMedicLabel.text = String(amedicament.dose)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy" //the format of the date that will be displayed
            
            self.dateStartLabel.text = formatter.string(for: amedicament.dateDebut)
            self.dateEndLabel.text = formatter.string(for: amedicament.dateFIn)
            
            self.numberPerDayLabel.text = String(amedicament.nbParJour)
            self.numberPerWeekLabel.text = String(amedicament.nbJourParSemaine)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
