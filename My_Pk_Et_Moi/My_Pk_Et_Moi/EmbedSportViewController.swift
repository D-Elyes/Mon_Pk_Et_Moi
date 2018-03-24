//
//  EmbedSportViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 14/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EmbedSportViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var sport : Activite? = nil
    
    var pickerView = UIPickerView()
   
    let typeSports = ["Sport équipe", "Course", "Yoga", "Musculation"]
    
    @IBOutlet weak var nomSport: UITextField!
    @IBOutlet weak var typeTextF: UITextField!
    @IBOutlet weak var objectif: UITextField!
    
    @IBOutlet weak var lundi: UISwitch!
    @IBOutlet weak var mardi: UISwitch!
    @IBOutlet weak var mercredi: UISwitch!
    @IBOutlet weak var jeudi: UISwitch!
    @IBOutlet weak var vendredi: UISwitch!
    @IBOutlet weak var samedi: UISwitch!
    @IBOutlet weak var dimanche: UISwitch!
    
    @IBOutlet weak var heure: UIDatePicker!
    
    
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
        return typeSports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeSports[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextF.text = typeSports[row]
        typeTextF.resignFirstResponder()
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
