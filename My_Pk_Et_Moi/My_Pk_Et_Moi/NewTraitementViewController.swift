//
//  NewTraitementViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 14/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import UserNotifications

class NewTraitementViewController: UIViewController, UITextFieldDelegate {

    
    @IBAction func saveActionButton(_ sender: Any) {
        
        guard let embedTraitementController = self.childViewControllers[0] as? EmbedTratiementViewController else {return}
        
        if embedTraitementController.nomMedicTextField.text?.isEmpty ?? true || embedTraitementController.doseTextField.text?.isEmpty ?? true || embedTraitementController.dateDebut.text?.isEmpty ?? true || embedTraitementController.dateFin.text?.isEmpty ?? true
        {
            DialogBoxHelper.alert(view: self,withTitle: "Erreur de saisie", andMessage: "Vous devez saisir tous les champs!!!!!")
        }
        else if embedTraitementController.datePickerDebut.date >= embedTraitementController.datePickerFin.date
        {
            DialogBoxHelper.alert(view: self, withTitle: "Erreur de date", andMessage: "La date de début ne peut pas etre supérieur que la date de fin!!!!!")
        }
        else if embedTraitementController.heurs.count == 0
        {
            DialogBoxHelper.alert(view: self, withTitle: "Erreur", andMessage: "Vous devez au moin saisir une heur de prise")
        }
        else
        {
            let traitement = Traitement(context: CoreDataManager.context)
            
            let medicament = Medicament(context: CoreDataManager.context)
            
            medicament.nomMedic = embedTraitementController.nomMedicTextField.text!
            medicament.dose = Int16(embedTraitementController.doseTextField!.text!)!
            
            traitement.concerne = medicament
            medicament.estConernePar?.adding(traitement)
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            guard let dateDebut = dateFormatter.date(from: embedTraitementController.dateDebut.text!) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            traitement.dateDebut = dateDebut as NSDate
            
            guard let dateFin = dateFormatter.date(from: embedTraitementController.dateFin.text!) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            traitement.dateFIn = dateFin as NSDate
            
            /*for i in embedTraitementController.heurs
            {
                    let prise = HeurPrise()
                   // prise.heur = i
                   // traitement.estPrisA?.adding(prise)
                
            }*/
            
            
            
            //scheduleNotification(nom: embedTraitementController.nomMedicTextField.text!)
            
            
            
            let alert = UIAlertController(title: "Opération reussite!", message: "Nouveau traitement ajouté avec succée", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (_)in
                self.dismiss(animated: true, completion: nil)
            })
            
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark : - Cancel and save new Traitiement
    
    @IBAction func cancelActionButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    // MARK: - Navigation
    let segueEmbedId = "embedFromNewMedicSegue"

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueEmbedId
        {
            let embedController = segue.destination as! EmbedTratiementViewController
            embedController.traitement = nil
        }
        
    }
    
    
    func scheduleNotification(nom: String)
    {
        
        //add atachment
        let myimage = "medication-capsule"
        guard let imageUrl = Bundle.main.url(forResource: myimage, withExtension: "png" ) else {
           
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "medicNoification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        notif.title = "Rappel medicament"
        notif.subtitle = "Reprise de medicament"
        notif.body = "C'est l'heur de prendre \(nom)"
        
        notif.attachments = [attachment]
        
        var dateInfo = DateComponents()
        dateInfo.hour = 18
        dateInfo.minute = 05
        
        let notifiTrigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        let request = UNNotificationRequest(identifier: "medicNoification", content: notif, trigger: notifiTrigger)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error : Error?) in
                if let theError = error
                {
                    print(theError.localizedDescription)
            }
        }
      //  UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in    })
    }
    
 

}
