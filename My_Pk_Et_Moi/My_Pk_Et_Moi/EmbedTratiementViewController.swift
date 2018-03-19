//
//  EmbedTratiementViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 16/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EmbedTratiementViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nomMedicTextField: UITextField!
    
    @IBOutlet weak var doseTextField: UITextField!
    
    @IBOutlet weak var dateDebut: UITextField!
    
    @IBOutlet weak var dateFin: UITextField!
    
    let datePickerDebut = UIDatePicker()
    let datePickerFin = UIDatePicker()
    
    @IBOutlet weak var qtteParJourTextField: UITextField!
    
    @IBOutlet weak var jourParSemaineTextField: UITextField!
    
    var medicament: Medicament? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        //make dateDebut pop up a datePicker when the user click on it
        
        datePickerDebut.datePickerMode = UIDatePickerMode.date
        datePickerDebut.addTarget(self, action: #selector(datePickedDebutValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        //we associate the datePicker to the TextField
        //let embedTraitementController = self.childViewControllers[0] as! EmbedTratiementViewController
        dateDebut.inputView = datePickerDebut
        dateDebut.text = formatter.string(from: datePickerDebut.date)
        
        //make dateFin pop up a datePicker when the user click on it
        
        datePickerFin.datePickerMode = UIDatePickerMode.date
        datePickerFin.addTarget(self, action: #selector(datePickedFinValueChanged(sender:)), for: UIControlEvents.valueChanged)
        datePickerFin.date = datePickerFin.date.addingTimeInterval(86400)
        dateFin.inputView = datePickerFin
        dateFin.text = formatter.string(from: datePickerFin.date )
        
        
        if let medicament = self.medicament
        {
            self.nomMedicTextField.text = medicament.nomMedicament
            self.doseTextField.text = String(medicament.dose)
            self.qtteParJourTextField.text = String(medicament.nbParJour)
            self.jourParSemaineTextField.text = String(medicament.nbJourParSemaine)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy" //the format of the date that will be displayed
            
            self.dateDebut.text = formatter.string(for: medicament.dateDebut)
            self.dateFin.text = formatter.string(for: medicament.dateFIn)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
    
    

}
