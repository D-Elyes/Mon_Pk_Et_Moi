//
//  EditMedicViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 17/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EditMedicViewController: UIViewController, UITextFieldDelegate {
    
    var medicament : Medicament? = nil
    var embedTraitementController : EmbedTratiementViewController? = nil
    
    let datePickerDebut = UIDatePicker()
    let datePickerFin = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard (self.medicament != nil) else {return}
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem : .save, target: self, action: #selector(self.saveAction))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        //make dateDebut pop up a datePicker when the user click on it
        
        datePickerDebut.datePickerMode = UIDatePickerMode.date
        datePickerDebut.addTarget(self, action: #selector(NewTraitementViewController.datePickedDebutValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        //we associate the datePicker to the TextField
        let embedTraitementController = self.childViewControllers[0] as! EmbedTratiementViewController
        embedTraitementController.dateDebut.inputView = datePickerDebut
        embedTraitementController.dateDebut.text = formatter.string(from: datePickerDebut.date)
        
        //make dateFin pop up a datePicker when the user click on it
        
        datePickerFin.datePickerMode = UIDatePickerMode.date
        datePickerFin.addTarget(self, action: #selector(NewTraitementViewController.datePickedFinValueChanged(sender:)), for: UIControlEvents.valueChanged)
        datePickerFin.date = datePickerFin.date.addingTimeInterval(86400)
        embedTraitementController.dateFin.inputView = datePickerFin
        embedTraitementController.dateFin.text = formatter.string(from: datePickerFin.date )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -Save
    @IBAction func saveAction(sender: UIBarButtonItem)
    {
        guard let medicament = self.medicament else {return}
        let editController = self.childViewControllers[0]as! EmbedTratiementViewController
        guard (editController.nomMedicTextField.text != "" || editController.doseTextField.text != "" || editController.dateDebut.text != "" || editController.dateFin.text != "" || editController.qtteParJourTextField.text != "" || editController.jourParSemaineTextField.text != "" ||
            datePickerDebut.date < datePickerFin.date)
            else
        {
            self.alert(withTitle: "Erreur de saisie", andMessage: "Champ manquant ou date debut depasse date Fin")
            return
        }
        
        medicament.nomMedicament =  editController.nomMedicTextField.text!
        
        
        medicament.dose = Int16(editController.doseTextField!.text!)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        medicament.dateDebut = dateFormatter.date(from: editController.dateDebut.text!) as NSDate?
        
        medicament.dateFIn = dateFormatter.date(from: editController.dateFin.text!) as NSDate?
        
         let alert = UIAlertController(title: "Opération reussite!", message: "Nouveau traitement ajouté avec succée", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            (_)in
            self.performSegue(withIdentifier: self.segueUnwindId, sender: self)
        })
        
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    

    // MARK: - Navigation
    let segueEmbedId = "embedFromEditMedicSegue"
    let segueUnwindId = "unwindToTraitementViewCOntrollerFromEditing"

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == self.segueEmbedId
        {
            let embedController = segue.destination as! EmbedTratiementViewController
            embedController.medicament  = self.medicament
        }
    }
    
    //MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
    //MARK: - Helper methode
    
    //MARK: - Helper
    
    /// This function is to update the textfield when the user change the date de debut
    ///
    /// - Parameter sender: the corresponding datePicker
    func datePickedDebutValueChanged(sender: UIDatePicker)
    {
        let embedTraitementController = self.childViewControllers[0] as! EmbedTratiementViewController
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateStyle = DateFormatter.Style.full
        //formatter.timeStyle = DateFormatter.Style.none
        
        embedTraitementController.dateDebut.text = formatter.string(from: sender.date)
    }
    
    /// This function is to update the textfield when the user change the date de fin
    ///
    /// - Parameter sender: the corresponding datePicker
    func datePickedFinValueChanged(sender: UIDatePicker)
    {
        let embedTraitementController = self.childViewControllers[0] as! EmbedTratiementViewController
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateStyle = DateFormatter.Style.long
        //formatter.timeStyle = DateFormatter.Style.none
        
        
        embedTraitementController.dateFin.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    /// show an alert dialog box with two message
    ///
    /// - Parameters:
    ///   - title: title of dialog box seen as main message
    ///   - msg: additional message used to describe context or additional information
    func alert(withTitle title: String, andMessage msg: String = "")
    {
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    

}
