//
//  EditMedicViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 17/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EditTraitementViewController: UIViewController, UITextFieldDelegate {
    
    var traitement : Traitement? = nil
    var embedTraitementController : EmbedTratiementViewController? = nil
    
    let datePickerDebut = UIDatePicker()
    let datePickerFin = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard (self.traitement != nil) else {return}
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem : .save, target: self, action: #selector(self.saveAction))
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -Save
    @IBAction func saveAction(sender: UIBarButtonItem)
    {
        guard let traitement = self.traitement else {return}
        let editController = self.childViewControllers[0]as! EmbedTratiementViewController
        if editController.nomMedicTextField.text?.isEmpty ?? true || editController.doseTextField.text?.isEmpty ?? true || editController.dateDebut.text?.isEmpty ?? true || editController.dateFin.text?.isEmpty ?? true
        {
            DialogBoxHelper.alert(view: self,withTitle: "Erreur de saisie", andMessage: "Vous devez saisir tous les champs!!!!!")
        }
        else if datePickerDebut.date >= datePickerFin.date
        {
            DialogBoxHelper.alert(view: self, withTitle: "Erreur de date", andMessage: "La date de début ne peut pas etre supérieur que la date de fin!!!!!")
        }
        else
        {
            traitement.concerne?.nomMedic =  editController.nomMedicTextField.text!
            
            
            traitement.concerne?.dose = Int16(editController.doseTextField!.text!)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            traitement.dateDebut = dateFormatter.date(from: editController.dateDebut.text!) as NSDate?
            
            traitement.dateFin = dateFormatter.date(from: editController.dateFin.text!) as NSDate?
            
            
            traitement.estPrisA = []
            
            for i in editController.heurs
            {
                let prise = HeurPrise(context: CoreDataManager.context)
                prise.heur = i
                
            
                
                    traitement.addToEstPrisA(prise)
                    prise.addToPriseDuTraitement(traitement)
                
                
            }
            
            let alert = UIAlertController(title: "Opération reussite!", message: "Nouveau traitement ajouté avec succée", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (_)in
                self.performSegue(withIdentifier: self.segueUnwindId, sender: self)
           
                //self.dismiss(animated: true, completion: nil)
            })
            
            
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    

    // MARK: - Navigation
    let segueEmbedId = "embedFromEditTraitementSegue"
    let segueUnwindId = "unwindToTraitementViewCOntrollerFromEditing"

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == self.segueEmbedId
        {
            let embedController = segue.destination as! EmbedTratiementViewController
            embedController.traitement  = self.traitement
        }
    }
    
    //MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
    

}
