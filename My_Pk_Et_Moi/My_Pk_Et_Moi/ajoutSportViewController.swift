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
    
    
    
    /*func saveNewSport(nomSport nom: String, typeSport type: String, objSport obj: String){ // à modifier !!!!!!!!
        // get context into application delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            // faire le message d'erreur
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        //create a sport
        let sport = Activite(context: context)
        sport.nom = nom
        sport.type = type
        sport.objectif = obj
        do{
            try context.save()
        }
        catch let error as NSError{
            // completer l'erreur
            return
        }
    }*/
    
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
        guard (nomSport != "" ) || (typeSport != "" ) else { return }
        // create a new Sports Managed Object
        let sport = Activite(context: CoreDataManager.context)
        // then modify it according to values
        sport.nom = nomSport
        sport.type = typeSport
        sport.objectif = objSport
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
