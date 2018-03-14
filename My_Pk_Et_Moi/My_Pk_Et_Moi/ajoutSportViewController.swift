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

    // Mark : - Formulaire ajout sport : cancel/save
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*func alertError(errorMsg error: String, userInfo user: String = ""){
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }*/
    

    @IBAction func saveAction(_ sender: Any) {
        guard let embedSportViewController = self.childViewControllers[0] as? EmbedSportViewController
            else {return}
        let nomSport : String = embedSportViewController.nomSport.text ?? ""
        let typeSport : String = embedSportViewController.typeTextF.text ?? ""
        let objSport : String = embedSportViewController.objectif.text ?? ""
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "hh mm"
        let heureSport = dateFormatter.string(from: embedSportViewController.heure.date)
        
        guard (nomSport != "" ) || (typeSport != "" ) else { return }
        // create a new Sports Managed Object
        let sport = Activite(context: CoreDataManager.context)
        // then modify it according to values
        sport.nom = nomSport
        sport.type = typeSport
        sport.objectif = objSport
        sport.heure = heureSport
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    let segueEmbedId = "embedFromNewSportSegue"
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueEmbedId{
            let embedController = segue.destination as! EmbedSportViewController
            embedController.sport = nil
        }
    }
    

}
