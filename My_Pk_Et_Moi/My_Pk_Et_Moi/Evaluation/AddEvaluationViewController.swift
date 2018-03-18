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
        /*// Mettre une condition qu'une seule sélection
         if self.on.isOn == true {let etat : String = "On"}
         else if self.off.isOn == true {let etat : String = "Off"}
         else {let etat : String = "Dyskenesies"}
         
         var listEvenement : [String] = []
         
         if self.chute.isOn == true { listEvenement.append("Chute") }
         if self.clic_bolus.isOn == true { listEvenement.append("Clic / bolus d'Apokinon") }
         if self.hallucination.isOn == true { listEvenement.append("Hallucination") }
         if self.prise_dispersible.isOn == true { listEvenement.append("Prise de dispersible") }
         if self.somnolence.isOn == true { listEvenement.append("Somnolence") }
         
         
         
         if let evaluationTmp = self.evaluation{
         self.evaluation sportTmp.nom
         //Ajouter les evenemnt problème avec too many
         }
         
         
         self.dismiss(animated: true, completion: nil)*/
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
