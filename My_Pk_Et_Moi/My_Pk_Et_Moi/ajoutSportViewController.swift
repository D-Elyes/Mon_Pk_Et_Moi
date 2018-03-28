//
//  ajoutSportViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 10/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class ajoutSportViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark : - Formulaire ajout sport : cancel/save
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveAction(_ sender: Any) {
        guard let embedSportViewController = self.childViewControllers[0] as? EmbedSportViewController
            else {return}
        let nomSport : String = embedSportViewController.nomSport.text ?? ""
        let typeSport : String = embedSportViewController.typeTextF.text ?? ""
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "HH:mm"
        let heureSport = dateFormatter.string(from: embedSportViewController.heure.date)
        
        guard (nomSport != "" ) || (typeSport != "" ) else {
            DialogBoxHelper.alert(view: self, withTitle: "Champs manquants", andMessage: "Formulaire incomplet")
            return
        }
        // create a new Sports Managed Object
        let sport = Activite(context: CoreDataManager.context)
        // then modify it according to values
        sport.nom = nomSport
        sport.type = typeSport
        sport.heure = heureSport
     
        
        // Add days
        // create each new JourSemaine Managed Object
        let lundi = JourSemaine(context: CoreDataManager.context)
        let mardi = JourSemaine(context: CoreDataManager.context)
        let mercredi = JourSemaine(context: CoreDataManager.context)
        let jeudi = JourSemaine(context: CoreDataManager.context)
        let vendredi = JourSemaine(context: CoreDataManager.context)
        let samedi = JourSemaine(context: CoreDataManager.context)
        let dimanche = JourSemaine(context: CoreDataManager.context)
        
        
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour,.minute], from: embedSportViewController.heure.date)
        if embedSportViewController.lundi.isOn == true {
            lundi.jour = "Lundi"
            sport.addToContenirJour(lundi)
            lundi.contenirActivite = sport
            NotificationsSchedule.scheduleNotification(hour: comp.hour!, minute: comp.minute!,weekDay: 2, day : nil,month: nil, image: "weightlifting", ext: "png", title: "Rappel Activite", subtitle: "Repirse d'uneactivite", body: "il est temps de faire \(embedSportViewController.nomSport.text!)",category: NotificationsSchedule.Notification.Category.sport, repeated: true)
        }
        if embedSportViewController.mardi.isOn == true {
            mardi.jour = "Mardi"
            sport.addToContenirJour(mardi)
            mardi.contenirActivite = sport
            NotificationsSchedule.scheduleNotification(hour: comp.hour!, minute: comp.minute!,weekDay: 3, day : nil,month: nil, image: "weightlifting", ext: "png", title: "Rappel Activite", subtitle: "Repirse d'uneactivite", body: "il est temps de faire \(embedSportViewController.nomSport.text!)",category: NotificationsSchedule.Notification.Category.sport, repeated: true)
        }
        if embedSportViewController.mercredi.isOn == true {
            mercredi.jour = "Mercredi"
            sport.addToContenirJour(mercredi)
            mercredi.contenirActivite = sport
            NotificationsSchedule.scheduleNotification(hour: comp.hour!, minute: comp.minute!, weekDay: 4,day : nil,month: nil, image: "weightlifting", ext: "png", title: "Rappel Activite", subtitle: "Repirse d'uneactivite", body: "il est temps de faire \(embedSportViewController.nomSport.text!)",category: NotificationsSchedule.Notification.Category.sport, repeated: true)
        }
        if embedSportViewController.jeudi.isOn == true {
            jeudi.jour = "Jeudi"
            sport.addToContenirJour(jeudi)
            jeudi.contenirActivite = sport
            NotificationsSchedule.scheduleNotification(hour: comp.hour!, minute: comp.minute!, weekDay: 5,day : nil,month: nil, image: "weightlifting", ext: "png", title: "Rappel Activite", subtitle: "Repirse d'uneactivite", body: "il est temps de faire \(embedSportViewController.nomSport.text!)",category: NotificationsSchedule.Notification.Category.sport, repeated: true)
        }
        if embedSportViewController.vendredi.isOn == true {
            vendredi.jour = "Vendredi"
            sport.addToContenirJour(vendredi)
            vendredi.contenirActivite = sport
            NotificationsSchedule.scheduleNotification(hour: comp.hour!, minute: comp.minute!, weekDay: 6,day : nil,month: nil, image: "weightlifting", ext: "png", title: "Rappel Activite", subtitle: "Repirse d'uneactivite", body: "il est temps de faire \(embedSportViewController.nomSport.text!)",category: NotificationsSchedule.Notification.Category.sport, repeated: true)
        }
        if embedSportViewController.samedi.isOn == true {
            samedi.jour = "Samedi"
            sport.addToContenirJour(samedi)
            samedi.contenirActivite = sport
            NotificationsSchedule.scheduleNotification(hour: comp.hour!, minute: comp.minute!, weekDay: 7,day : nil,month: nil, image: "weightlifting", ext: "png", title: "Rappel Activite", subtitle: "Repirse d'uneactivite", body: "il est temps de faire \(embedSportViewController.nomSport.text!)",category: NotificationsSchedule.Notification.Category.sport, repeated: true)
        }
        if embedSportViewController.dimanche.isOn == true {
            dimanche.jour = "Dimanche"
            sport.addToContenirJour(dimanche)
            dimanche.contenirActivite = sport
            NotificationsSchedule.scheduleNotification(hour: comp.hour!, minute: comp.minute!, weekDay: 1,day : nil,month: nil, image: "weightlifting", ext: "png", title: "Rappel Activite", subtitle: "Repirse d'uneactivite", body: "il est temps de faire \(embedSportViewController.nomSport.text!)",category: NotificationsSchedule.Notification.Category.sport, repeated: true)
        }
       
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*// MARK: - Navigation
    
    let segueEmbedId = "embedFromNewSportSegue"
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueEmbedId{
            let embedController = segue.destination as! EmbedSportViewController
            embedController.sport = nil
        }
    }*/
    
    let segueEmbedId = "embedFromNewSportSegue"
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueEmbedId
        {
            let embedController = segue.destination as! EmbedSportViewController
            embedController.sport = nil
        }
        
    }
    

}
