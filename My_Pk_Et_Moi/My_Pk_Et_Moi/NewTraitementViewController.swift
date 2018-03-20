//
//  NewTraitementViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 14/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class NewTraitementViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nomMedicTextField: UITextField!
    
    @IBOutlet weak var doseTextField: UITextField!
    
    @IBOutlet weak var dateDebut: UITextField!
    
    @IBOutlet weak var dateFin: UITextField!
    
    
    
    
    
    @IBOutlet weak var qtteParJourTextField: UITextField!
    
    @IBOutlet weak var jourParSemaineTextField: UITextField!
    
    @IBAction func saveActionButton(_ sender: Any) {
        guard let embedTraitementController = self.childViewControllers[0] as? EmbedTratiementViewController else {return}
        
        if embedTraitementController.nomMedicTextField.text?.isEmpty ?? true || embedTraitementController.doseTextField.text?.isEmpty ?? true || embedTraitementController.dateDebut.text?.isEmpty ?? true || embedTraitementController.dateFin.text?.isEmpty ?? true || embedTraitementController.qtteParJourTextField.text?.isEmpty ?? true || embedTraitementController.jourParSemaineTextField.text?.isEmpty ?? true
        {
            DialogBoxHelper.alert(view: self,withTitle: "Erreur de saisie", andMessage: "Vous devez saisir tous les champs!!!!!")
        }
        else if embedTraitementController.datePickerDebut.date >= embedTraitementController.datePickerFin.date
        {
            DialogBoxHelper.alert(view: self, withTitle: "Erreur de date", andMessage: "La date de début ne peut pas etre supérieur que la date de fin!!!!!")
        }
        else
        {
            let medic = Medicament(context: CoreDataManager.context)
            
             medic.nomMedicament =  embedTraitementController.nomMedicTextField.text!
            
            
            medic.dose = Int16(embedTraitementController.doseTextField!.text!)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            guard let dateDebut = dateFormatter.date(from: embedTraitementController.dateDebut.text!) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            medic.dateDebut = dateDebut as NSDate
            
            guard let dateFin = dateFormatter.date(from: embedTraitementController.dateFin.text!) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            medic.dateFIn = dateFin as NSDate
            
            
            medic.nbParJour = Int16(embedTraitementController.qtteParJourTextField!.text!)!
            medic.nbJourParSemaine = Int16(embedTraitementController.jourParSemaineTextField!.text!)!
            
            
            
            
            
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
            embedController.medicament = nil
        }
    }
    
 

}
