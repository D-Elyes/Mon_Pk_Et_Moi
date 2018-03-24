//
//  ShowMedicViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 13/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData


class ShowTraitementViewController: UIViewController {

    @IBOutlet weak var nomMedicLabel: UILabel!
    
    @IBOutlet weak var doseMedicLabel: UILabel!
    
    @IBOutlet weak var dateStartLabel: UILabel!
    
    @IBOutlet weak var dateEndLabel: UILabel!
    
    
    @IBOutlet weak var heurPrise: UILabel!
    
    
    var traitement : Traitement? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if a medicament exist then display it
        if let aTraitement = self.traitement
        {
            self.nomMedicLabel.text = aTraitement.concerne?.nomMedic
            print((aTraitement.concerne?.dose)!)
            self.doseMedicLabel.text = String((aTraitement.concerne?.dose)!)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy" //the format of the date that will be displayed
            
            self.dateStartLabel.text = formatter.string(for: aTraitement.dateDebut)
            self.dateEndLabel.text = formatter.string(for: aTraitement.dateFin)
            formatter.dateFormat = "HH:MM"
            self.heurPrise.text = ""
            
            if let heurs = aTraitement.estPrisA
            {
                for heursPrise in heurs
                {
                    if let h = heursPrise as? HeurPrise
                    {
                        self.heurPrise.text = self.heurPrise.text! +   formatter.string(for: h.heur)! + "\n"
                    }
                }
            }
            
            
            
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
