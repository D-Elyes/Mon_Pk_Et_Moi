//
//  TraitementNotificationViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 21/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class TraitementNotificationViewController: UIViewController {
    
    var medicament : Medicament? = nil
    var dateJourPrise : [UIDatePicker] = []
    var dateHeurPrise : [UIDatePicker] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(medicament)
        
        if let medicament = self.medicament
        {
            
            
            let nbrPriseParJour = medicament.nbParJour
            let nbrJourParSemaine = medicament.nbJourParSemaine
            
            for i in 0..<nbrJourParSemaine
            {
                let label : UILabel = UILabel()
                label.text = "Donner la date du jour n°\(i+1)"
                
                let datePicker: UIDatePicker = UIDatePicker()
                
                datePicker.frame = CGRect(x: CGFloat(10 * i+1), y: CGFloat(20 * i+1), width:self.view.frame.width, height : 200)
                
                datePicker.datePickerMode = .date
                datePicker.timeZone = NSTimeZone.local
                
                self.view.addSubview(datePicker)
                
                dateJourPrise.append(datePicker)
                
                
                for j in 0..<nbrPriseParJour
                {
                    let label2 : UILabel = UILabel()
                    label2.text = "Donner l'heur de la prise  n°\(j+1)"
                    
                    let datePickerTime: UIDatePicker = UIDatePicker()
                    datePickerTime.datePickerMode = .time
                    
                    self.view.addSubview(datePickerTime)
                    
                    dateHeurPrise.append(datePickerTime)
                }
                
                
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
