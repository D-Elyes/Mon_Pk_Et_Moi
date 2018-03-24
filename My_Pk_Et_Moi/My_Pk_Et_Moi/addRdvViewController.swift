//
//  addRdvViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 15/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class addRdvViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var rdv : Rdv? = nil
    
    var pickerView = UIPickerView()
    
    let medecins = ["Neurologue", "Dentiste"] // requete pour avoir tout les medecins
    
    @IBOutlet weak var datePick: UIDatePicker!
    @IBOutlet weak var lieuTextF: UITextField!
    @IBOutlet weak var heurePick: UIDatePicker!
    @IBOutlet weak var medTextF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lieuTextF.delegate = self
        
        medTextF.inputView = pickerView
        medTextF.textAlignment = .center
        medTextF.placeholder = "Selection medecin"
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
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
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let lieuRdv : String = self.lieuTextF.text ?? ""
        let medecinRdv : String = self.medTextF.text ?? ""
        
        let dateRdv = self.datePick.date
        
        let dateFormatterHeure = DateFormatter()
        dateFormatterHeure.locale = Locale(identifier: "fr_FR")
        dateFormatterHeure.dateFormat = "hh:mm"
        let heureRdv = dateFormatterHeure.string(from: self.heurePick.date)
        
        guard (lieuRdv != "" ) || (medecinRdv != "" ) else { return }
        // create a new Rdv Managed Object
        let rdv = Rdv(context: CoreDataManager.context)
        // then modify it according to values
        rdv.date = dateRdv as NSDate
        rdv.heure = heureRdv
        rdv.lieu = lieuRdv
        // create a new Medecin Managed Object
        let medecin = Medecin(context: CoreDataManager.context)
        // then modify it according to values
        medecin.specialite = medecinRdv
        rdv.concerneMedecin? = medecin
        medecin.addToAvoirRdv(rdv)
        
        //Create an evaluation if the Rdv is with a neurologue
        if medecinRdv == "Neurologue"{
            // create a new Evalaution Managed Object
            let evaluation = Evaluation(context: CoreDataManager.context)
            // then modify it according to values
            evaluation.concerneRdv?.date = dateRdv as NSDate
            evaluation.concerneRdv?.heure = heureRdv
            evaluation.concerneRdv = rdv
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - TextField Delegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - PickerView Delegate
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return medecins.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medecins[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        medTextF.text = medecins[row]
        medTextF.resignFirstResponder()
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
