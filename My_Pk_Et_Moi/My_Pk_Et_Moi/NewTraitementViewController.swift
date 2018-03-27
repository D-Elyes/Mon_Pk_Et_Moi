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
            medicament.estConcernePar?.adding(traitement)
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            guard let dateDebut = dateFormatter.date(from: embedTraitementController.dateDebut.text!) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            traitement.dateDebut = dateDebut as NSDate
            
            guard let dateFin = dateFormatter.date(from: embedTraitementController.dateFin.text!) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            traitement.dateFin = dateFin as NSDate
            dateFormatter.dateFormat = "HH:mm"
            let calendar = Calendar.current
            var heur : Int
            var minute : Int
            //let priseA = traitement.mutableSetValue(forKey: #keyPath(Heurprise.priseDuTraitement))
            
            for i in embedTraitementController.heurs
            {
                let prise = HeurPrise(context: CoreDataManager.context)
                prise.heur = i
                
                traitement.addToEstPrisA(prise)
                prise.addToPriseDuTraitement(traitement)
                
                let comp = calendar.dateComponents([.hour,.minute], from: i as Date)
                heur = comp.hour!
                minute = comp.minute!
                
                scheduleNotification(nom: embedTraitementController.nomMedicTextField.text!, hour: heur, minute: minute,image: "medication-capsule", ext: "png",title: "Rappel medicament",subtitle: "Prise de medicament",body: "C'est l'heur de prendre \(embedTraitementController.nomMedicTextField.text!)", dateFin : embedTraitementController.datePickerFin.date)
                
                
            }
            
            
            
          
            
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
    
    
    func scheduleNotification(nom: String, hour: Int, minute: Int, image : String, ext : String, title : String, subtitle : String, body : String, dateFin : Date)
    {
        
        //add atachment
        
        guard let imageUrl = Bundle.main.url(forResource: image, withExtension: ext ) else {
           
            return
        }
        
        let identifier : String = UUID().uuidString
        var attachment: UNNotificationAttachment
        
        
        
        attachment = try! UNNotificationAttachment(identifier: identifier, url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        notif.title = title
        notif.subtitle = subtitle
        notif.body = body
        notif.categoryIdentifier = AppDelegate.Notification.Category.traitement
        notif.userInfo = ["Redirection" : "Traitement"]
        //let dateFinMedic = ["fin" : dateFin]
       // notif.userInfo = dateFinMedic
        
        notif.attachments = [attachment]
        
        var dateInfo = DateComponents()
        dateInfo.hour = hour
        dateInfo.minute = minute
        
        //let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let notifTrigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: notif, trigger: notifTrigger)
        
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
