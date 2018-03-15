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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let datePickerDebut = UIDatePicker()
        datePickerDebut.datePickerMode = UIDatePickerMode.date
        datePickerDebut.addTarget(self, action: #selector(NewTraitementViewController.datePickedDebutValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        dateDebut.inputView = datePickerDebut
        
        let datePickerFin = UIDatePicker()
        datePickerFin.datePickerMode = UIDatePickerMode.date
        datePickerFin.addTarget(self, action: #selector(NewTraitementViewController.datePickedFinValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        dateDebut.inputView = datePickerDebut
        dateFin.inputView = datePickerFin
        // Do any additional setup after loading the view.
        
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

}
