//
//  AddEvaluationViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 17/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class AddEvaluationViewController: UIViewController {

    var evaluation : Evaluation? = nil
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var heureLabel: UILabel!
    
    @IBOutlet weak var on: UISwitch!
    @IBOutlet weak var off: UISwitch!
    @IBOutlet weak var dyskinesies: UISwitch!
    
    @IBOutlet weak var somnolence: UISwitch!
    @IBOutlet weak var chute: UISwitch!
    @IBOutlet weak var hallucination: UISwitch!
    @IBOutlet weak var prise_dispersible: UISwitch!
    @IBOutlet weak var clic_bolus: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        // Mettre une condition qu'une seule sélection
         //guard (nomSport != "" ) || (typeSport != "" ) else { return } Changer la condition !
         // create a new Evaluation Managed Object
         let evaluation = Evaluation(context: CoreDataManager.context)
         
         /*
         if self.on.isOn == true {let etat : String = "On"}
         else if self.off.isOn == true {let etat : String = "Off"}
         else {let etat : String = "Dyskenesies"}*/
        // Add result
        // create each new Resultat Managed Object
        /*let on = Etat(context: CoreDataManager.context)
        let off = Etat(context: CoreDataManager.context)
        let dyskinesies = Etat(context: CoreDataManager.context)

    
        if self.on.isOn == true {
            chute.evenement = ""
            evaluation
        }*/

        
        // Add Event
        // create each new Evenement Managed Object
        let chute = Evenement(context: CoreDataManager.context)
        let clic_bolus = Evenement(context: CoreDataManager.context)
        let hallucination = Evenement(context: CoreDataManager.context)
        let prise_dispersible = Evenement(context: CoreDataManager.context)
        let somnolence = Evenement(context: CoreDataManager.context)
        
        if self.chute.isOn == true {
            chute.evenement = ""
            evaluation.addToContenirEvenement(chute)
        }
        if self.clic_bolus.isOn == true {
            clic_bolus.evenement = ""
            evaluation.addToContenirEvenement(clic_bolus)
        }
        if self.hallucination.isOn == true {
            hallucination.evenement = ""
            evaluation.addToContenirEvenement(hallucination)
        }
        if self.prise_dispersible.isOn == true {
            prise_dispersible.evenement = ""
            evaluation.addToContenirEvenement(prise_dispersible)
        }
        if self.somnolence.isOn == true {
            somnolence.evenement = ""
            evaluation.addToContenirEvenement(somnolence)
        }
        
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
