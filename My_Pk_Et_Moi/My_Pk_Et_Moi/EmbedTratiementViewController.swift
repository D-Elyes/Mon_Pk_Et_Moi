//
//  EmbedTratiementViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 16/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EmbedTratiementViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nomMedicTextField: UITextField!
    
    @IBOutlet weak var doseTextField: UITextField!
    
    @IBOutlet weak var dateDebut: UITextField!
    
    @IBOutlet weak var dateFin: UITextField!
    
    
    
    @IBOutlet weak var qtteParJourTextField: UITextField!
    
    @IBOutlet weak var jourParSemaineTextField: UITextField!
    
    var medicament: Medicament? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let medicament = self.medicament
        {
            self.nomMedicTextField.text = medicament.nomMedicament
            self.doseTextField.text = String(medicament.dose)
            self.qtteParJourTextField.text = String(medicament.nbParJour)
            self.jourParSemaineTextField.text = String(medicament.nbJourParSemaine)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy" //the format of the date that will be displayed
            
            self.dateDebut.text = formatter.string(for: medicament.dateDebut)
            self.dateFin.text = formatter.string(for: medicament.dateFIn)
            
        }
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
