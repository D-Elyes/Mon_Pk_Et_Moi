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
        
        // get current time
        let date = Date()
        let dateFormatterHeure = DateFormatter()
        dateFormatterHeure.locale = Locale(identifier: "fr_FR")
        dateFormatterHeure.dateFormat = "hh:mm"
        let heure = dateFormatterHeure.string(from: date)
        
        // If the add is not in the 5 days
        guard (components.day! <= 5) && (components.day! > 0) else {
                DialogBoxHelper.alert(view: self, withTitle: "Mauvaise période d'évaluation", andMessage: "Une évaluation peut être effectuée durant les 5 jours avant le rendez-vous")
            return
        }
        
        //If the user fill more than one "Etat"
        if (((self.on.isOn == true) && (self.off.isOn == true)) || ((self.on.isOn == true) && (self.dyskinesies.isOn == true)) || ((self.off.isOn == true) && (self.dyskinesies.isOn == true)) || ((self.on.isOn == true) && (self.off.isOn == true) && (self.dyskinesies.isOn == true))){
            DialogBoxHelper.alert(view: self, withTitle: "Formulaire", andMessage: "Vous devez renseigner qu'un seul etat")
            return
        }
        else if (self.on.isOn == false) && (self.off.isOn == false) && (self.dyskinesies.isOn == false){
            DialogBoxHelper.alert(view: self, withTitle: "Formulaire", andMessage: "Vous n'avez pas renseigné d'état")
            return
        }
        
        // check if the day before rdv is already created
        var jourAvantRdv : JourEvaluation? = nil
        var possedeJour : Bool = false
        if let jours = evaluation?.contenirJourEvaluation{
            for jour in jours{
                if let j = jour as? JourEvaluation{
                    if j.jour == String(components.day!) + " jour"{
                        possedeJour = true
                        jourAvantRdv = j
                    }
                }
            }
        }
        
        
        //set value of new day
        if possedeJour == false {
            // create a new jourEvaluation Managed Object
            jourAvantRdv = JourEvaluation(context: CoreDataManager.context)
            jourAvantRdv?.jour = String(components.day!) + " jour"
            jourAvantRdv?.correspondreEvaluation = self.evaluation
            self.evaluation?.addToContenirJourEvaluation(jourAvantRdv!)
            
        }
        
        var resEtat : String = ""
        if self.on.isOn == true {resEtat = "On"}
        else if self.off.isOn == true {resEtat = "Off"}
        else {resEtat = "Dyskenesies"}
        
        // Add result
        // create each new Resultat Managed Object
        let etat = Etat(context: CoreDataManager.context)
        etat.reponse = resEtat
        etat.heure = heure
        etat.correspondreJourEvaluation = jourAvantRdv
        jourAvantRdv?.addToContenirEtat(etat)
        
        // Add Event
        // create each new Evenement Managed Object
        let chute = Evenement(context: CoreDataManager.context)
        let clic_bolus = Evenement(context: CoreDataManager.context)
        let hallucination = Evenement(context: CoreDataManager.context)
        let prise_dispersible = Evenement(context: CoreDataManager.context)
        let somnolence = Evenement(context: CoreDataManager.context)
        
        if self.chute.isOn == true {
            chute.evenement = "Chute"
            self.evaluation?.addToContenirEvenement(chute)
            chute.appartientAEva = self.evaluation
        }
        if self.clic_bolus.isOn == true {
            clic_bolus.evenement = "Clic / bolus d'Apokinon"
            self.evaluation?.addToContenirEvenement(clic_bolus)
            clic_bolus.appartientAEva = self.evaluation
        }
        if self.hallucination.isOn == true {
            hallucination.evenement = "Hallucination"
            self.evaluation?.addToContenirEvenement(hallucination)
            hallucination.appartientAEva = self.evaluation
        }
        if self.prise_dispersible.isOn == true {
            prise_dispersible.evenement = "Prise de dispersible"
            self.evaluation?.addToContenirEvenement(prise_dispersible)
            prise_dispersible.appartientAEva = self.evaluation
        }
        if self.somnolence.isOn == true {
            somnolence.evenement = "Somnolence"
            self.evaluation?.addToContenirEvenement(somnolence)
            somnolence.appartientAEva = self.evaluation
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
