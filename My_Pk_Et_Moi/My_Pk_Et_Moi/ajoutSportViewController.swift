//
//  ajoutSportViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 10/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class ajoutSportViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    
    @IBOutlet weak var nomSport: UITextField!
    @IBOutlet weak var typeSport: UIPickerView!
    @IBOutlet weak var objectif: UITextField!
    
    @IBOutlet weak var lundi: UISwitch!
    @IBOutlet weak var mardi: UISwitch!
    @IBOutlet weak var mercredi: UISwitch!
    @IBOutlet weak var jeudi: UISwitch!
    @IBOutlet weak var vendredi: UISwitch!
    @IBOutlet weak var samedi: UISwitch!
    @IBOutlet weak var dimanche: UISwitch!
    
    @IBOutlet weak var heure: UIDatePicker!
    
    let typeSports = ["Sport équipe", "Course", "Yoga", "Musculation"]
    
    @IBAction func ajouter(_ sender: UIButton) {
        let nom = nomSport.text
        
        let obj = objectif.text
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeSport.delegate = self
        typeSport.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return typeSports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeSports[row]
    }
    
    /*func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }*/
    
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
