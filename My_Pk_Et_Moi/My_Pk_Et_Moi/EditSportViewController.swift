//
//  EditSportViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 13/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EditSportViewController: UIViewController {

    var sport : Activite? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard (self.sport != nil) else { return }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveAction))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       
    //MARK: -Save
    @IBAction func saveAction(sender: UIBarButtonItem)
    {
        guard let sport = self.sport else {return}
        let editController = self.childViewControllers[0] as! EmbedSportViewController
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        sport.nom = editController.nomSport.text!
        sport.type = editController.typeTextF.text!
        sport.heure = formatter.string(from: editController.heure.date)
       
        sport.contenirJour = []
        
        let lundi = JourSemaine(context: CoreDataManager.context)
        let mardi = JourSemaine(context: CoreDataManager.context)
        let mercredi = JourSemaine(context: CoreDataManager.context)
        let jeudi = JourSemaine(context: CoreDataManager.context)
        let vendredi = JourSemaine(context: CoreDataManager.context)
        let samedi = JourSemaine(context: CoreDataManager.context)
        let dimanche = JourSemaine(context: CoreDataManager.context)
        
        if editController.lundi.isOn == true {
            lundi.jour = "Lundi"
            sport.addToContenirJour(lundi)
            lundi.contenirActivite = sport
        }
        if editController.mardi.isOn == true {
            mardi.jour = "Mardi"
            sport.addToContenirJour(mardi)
            mardi.contenirActivite = sport
        }
        if editController.mercredi.isOn == true {
            mercredi.jour = "Mercredi"
            sport.addToContenirJour(mercredi)
            mercredi.contenirActivite = sport
        }
        if editController.jeudi.isOn == true {
            jeudi.jour = "Jeudi"
            sport.addToContenirJour(jeudi)
            jeudi.contenirActivite = sport
        }
        if editController.vendredi.isOn == true {
            vendredi.jour = "Vendredi"
            sport.addToContenirJour(vendredi)
            vendredi.contenirActivite = sport
        }
        if editController.samedi.isOn == true {
            samedi.jour = "Samedi"
            sport.addToContenirJour(samedi)
            samedi.contenirActivite = sport
        }
        if editController.dimanche.isOn == true {
            dimanche.jour = "Dimanche"
            sport.addToContenirJour(dimanche)
            dimanche.contenirActivite = sport
        }

        
        
        self.performSegue(withIdentifier: self.segueUnwindId, sender: self)
        
        
    }
    

    
    // MARK: - Navigation

    let segueEmbedId = "embedFromEditSportSegue"
    let segueUnwindId = "unwindToSportViewControllerFromEditing"
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueEmbedId{
            let embedController = segue.destination as! EmbedSportViewController
            embedController.sport = self.sport
        }
    }
    

}
