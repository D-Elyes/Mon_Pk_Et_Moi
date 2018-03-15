//
//  EmbedRdvViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 15/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EmbedRdvViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var rdv : Rdv? = nil
    
    var pickerView = UIPickerView()
    
    let medecins = ["neurologue", "dentiste"] // requete pour avoir tout les medecins
    
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
    
    
    
    
    
    
    // MARK: - TextField Delegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool { // a modifier clavier ne s'affiche pas !!!!!!!!!!!!!!!
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
