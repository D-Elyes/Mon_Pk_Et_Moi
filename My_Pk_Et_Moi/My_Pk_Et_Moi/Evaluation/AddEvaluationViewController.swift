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
        self.dateLabel.text = self.evaluation?.concerneRdv?.convertDate(dateModify: (self.evaluation?.concerneRdv?.date)!)
        self.heureLabel.text = self.evaluation?.concerneRdv?.heure
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        //get the number of days between the current date and the date of the Rdv into jourRestant
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: NSDate() as Date)
        let date2 = calendar.startOfDay(for: (evaluation?.concerneRdv?.date)! as Date)
        let flags = NSCalendar.Unit.day
        let components = calendar.components(flags, from: date1, to: date2)
        
        // get current time into format string
        let date = Date()
        let dateFormatterHeure = DateFormatter()
        dateFormatterHeure.locale = Locale(identifier: "fr_FR")
        dateFormatterHeure.dateFormat = "hh:mm"
        let heure = dateFormatterHeure.string(from: date)
        
        
        
        // create a new jourEvaluation Managed Object
        let jourAvantRdv = JourEvaluation(context: CoreDataManager.context)
        jourAvantRdv.jour = String(components.day!) + " jour"
        jourAvantRdv.addToCorrespondreEvaluation(self.evaluation!)
        self.evaluation?.addToContenirJourEvaluation(jourAvantRdv)
        
        // create a new Evaluation Managed Object
        //let evaluation = Evaluation(context: CoreDataManager.context)
        
        var resEtat : String = ""
        if self.on.isOn == true {resEtat = "On"}
        else if self.off.isOn == true {resEtat = "Off"}
        else {resEtat = "Dyskenesies"}


        
        // Add result
        // create each new Resultat Managed Object
        let etat = Etat(context: CoreDataManager.context)
        etat.reponse = resEtat
        etat.heure = heure
        etat.addToCorrespondreJourEvaluation(jourAvantRdv)
        jourAvantRdv.addToContenirEtat(etat)
        
        
        // Add Event
        // create each new Evenement Managed Object
        let chute = Evenement(context: CoreDataManager.context)
        let clic_bolus = Evenement(context: CoreDataManager.context)
        let hallucination = Evenement(context: CoreDataManager.context)
        let prise_dispersible = Evenement(context: CoreDataManager.context)
        let somnolence = Evenement(context: CoreDataManager.context)
        
        if self.chute.isOn == true {
            chute.evenement = ""
            self.evaluation?.addToContenirEvenement(chute)
        }
        if self.clic_bolus.isOn == true {
            clic_bolus.evenement = ""
            self.evaluation?.addToContenirEvenement(clic_bolus)
        }
        if self.hallucination.isOn == true {
            hallucination.evenement = ""
            self.evaluation?.addToContenirEvenement(hallucination)
        }
        if self.prise_dispersible.isOn == true {
            prise_dispersible.evenement = ""
            self.evaluation?.addToContenirEvenement(prise_dispersible)
        }
        if self.somnolence.isOn == true {
            somnolence.evenement = ""
            self.evaluation?.addToContenirEvenement(somnolence)
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
