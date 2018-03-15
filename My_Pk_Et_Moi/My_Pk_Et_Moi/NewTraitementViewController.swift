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
    
    
    let datePickerDebut = UIDatePicker()
    let datePickerFin = UIDatePicker()
    
    
    @IBOutlet weak var qtteParJourTextField: UITextField!
    
    @IBOutlet weak var jourParSemaineTextField: UITextField!
    
    @IBAction func saveActionButton(_ sender: Any) {
        
        if nomMedicTextField.text?.isEmpty ?? true || doseTextField.text?.isEmpty ?? true || dateDebut.text?.isEmpty ?? true || dateFin.text?.isEmpty ?? true || qtteParJourTextField.text?.isEmpty ?? true || jourParSemaineTextField.text?.isEmpty ?? true
        {
            alert(withTitle: "Erreur de saisie", andMessage: "Vous devez saisir tous les champs!!!!!")
        }
        else if datePickerDebut.date >= datePickerFin.date
        {
            alert(withTitle: "Erreur de date", andMessage: "La date de début ne peut pas etre supérieur que la date de fin!!!!!")
        }
        else
        {
            let alert = UIAlertController(title: "Opération reussite!", message: "Nouveau traitement ajouté avec succée", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (_)in
                self.performSegue(withIdentifier: "unWindToTraitement", sender: self)
            })
            
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        //make dateDebut pop up a datePicker when the user click on it
        //datePickerDebut = UIDatePicker() //we create our datePicker
        datePickerDebut.datePickerMode = UIDatePickerMode.date
        datePickerDebut.addTarget(self, action: #selector(NewTraitementViewController.datePickedDebutValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        //we associate the datePicker to the TextField
        dateDebut.inputView = datePickerDebut
        dateDebut.text = formatter.string(from: datePickerDebut.date)
        
        //make dateFin pop up a datePicker when the user click on it
        //datePickerFin = UIDatePicker()
        datePickerFin.datePickerMode = UIDatePickerMode.date
        datePickerFin.addTarget(self, action: #selector(NewTraitementViewController.datePickedFinValueChanged(sender:)), for: UIControlEvents.valueChanged)
        datePickerFin.date = datePickerFin.date.addingTimeInterval(86400)
        dateFin.inputView = datePickerFin
        dateFin.text = formatter.string(from: datePickerFin.date )
       
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Helper -
    
    /// This function is to update the textfield when the user change the date de debut
    ///
    /// - Parameter sender: the corresponding datePicker
    func datePickedDebutValueChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateStyle = DateFormatter.Style.full
        //formatter.timeStyle = DateFormatter.Style.none
        
        dateDebut.text = formatter.string(from: sender.date)
    }
    
    /// This function is to update the textfield when the user change the date de fin
    ///
    /// - Parameter sender: the corresponding datePicker
    func datePickedFinValueChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateStyle = DateFormatter.Style.long
        //formatter.timeStyle = DateFormatter.Style.none
        
       
        dateFin.text = formatter.string(from: sender.date)
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
