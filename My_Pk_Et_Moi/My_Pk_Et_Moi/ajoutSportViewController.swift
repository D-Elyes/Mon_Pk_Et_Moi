//
//  ajoutSportViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 10/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class ajoutSportViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var pickerView = UIPickerView()
    
    @IBOutlet weak var nomSport: UITextField!
    @IBOutlet weak var objectif: UITextField!
    @IBOutlet weak var typeTextF: UITextField!
    
    @IBOutlet weak var lundi: UISwitch!
    @IBOutlet weak var mardi: UISwitch!
    @IBOutlet weak var mercredi: UISwitch!
    @IBOutlet weak var jeudi: UISwitch!
    @IBOutlet weak var vendredi: UISwitch!
    @IBOutlet weak var samedi: UISwitch!
    @IBOutlet weak var dimanche: UISwitch!
    
    @IBOutlet weak var heure: UIDatePicker!
    
    // Mark : - Formulaire ajout sport : cancel/save
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let typeSports = ["Sport équipe", "Course", "Yoga", "Musculation"]
    
    /*@IBAction func ajouter(_ sender: UIButton) {
        //let jour = "lundi" // à modifier !!!!!!
        //let heur = "10h00" // à modifier !!!!!!
        
        guard let nomField = nomSport.text, let typeField = typeTextF.text, let objField = objectif.text else { //a modifier !
            // afficher pop erreur formulaire
            return
        }
        self.saveNewSport(nomSport: nomField, typeSport: typeField, objSport: objField) //à compléter !!!!!!!!!
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nomSport.delegate = self
        self.objectif.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        typeTextF.inputView = pickerView
        typeTextF.textAlignment = .center
        typeTextF.placeholder = "Selection Type"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    
    // MARK: - TextField Delegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool { // a modifier clavier ne s'affiche pas !!!!!!!!!!!!!!!
        textField.resignFirstResponder()
        return true
    }
    
     // MARK: - PickerView Delegate
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return typeSports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeSports[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextF.text = typeSports[row]
        typeTextF.resignFirstResponder()
    }
    
    
    
    func saveNewSport(nomSport nom: String, typeSport type: String, objSport obj: String){ // à modifier !!!!!!!!
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
    }
    
    /*func alertError(errorMsg error: String, userInfo user: String = ""){
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
