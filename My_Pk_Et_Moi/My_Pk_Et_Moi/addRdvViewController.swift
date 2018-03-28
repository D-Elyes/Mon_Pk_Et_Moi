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
    
    let medecins : [String] = ["Psychiatre","Neurologue","Gériatre","Neurochirurgien","Gastro-entérologue","Urologue","Ophtalmologiste","ORL-phoniatre","Rhumatologue","Pneumologue","Cardiologue","Chirurgien-dentiste"]
    
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
        medTextF.text = medecins[0]
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Mark : - Form add Rdv : cancel/save

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
        
        guard (lieuRdv != "" ) || (medecinRdv != "" ) else {
            DialogBoxHelper.alert(view: self, withTitle: "Champs manquants", andMessage: "Formulaire incomplet")
            return
        }
        
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
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.day,.month], from: dateRdv)
        //Create an evaluation if the Rdv is with a neurologue
        if medecinRdv == "Neurologue"{
            // create a new Evalaution Managed Object
            let evaluation = Evaluation(context: CoreDataManager.context)
            // then modify it according to values
            evaluation.concerneRdv?.date = dateRdv as NSDate
            evaluation.concerneRdv?.heure = heureRdv
            evaluation.concerneRdv = rdv
            NotificationsSchedule.scheduleNotification(hour: 4, minute: 05,weekDay: nil, day: (comp.day!-6),month : comp.month, image: "evaluation", ext: "png", title: "Rappel d'evaluation", subtitle: "Faire les evaluation", body: "Commencer à remplir la fiche d'evaluation à partir de demain", category: NotificationsSchedule.Notification.Category.rdv, repeated: false)
            self.dismiss(animated: true, completion: nil)
            
        }
      
        NotificationsSchedule.scheduleNotification(hour: 10, minute: 00,weekDay: nil, day: (comp.day!-1),month : comp.month, image: "medical-notes-symbol-of-a-list-paper-on-a-clipboard", ext: "png", title: "Rappel de rendez-vous", subtitle: "Rendez-vous proche", body: "Demain vous avez un rendez-vous", category: NotificationsSchedule.Notification.Category.rdv, repeated: false)
            self.dismiss(animated: true, completion: nil)
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
