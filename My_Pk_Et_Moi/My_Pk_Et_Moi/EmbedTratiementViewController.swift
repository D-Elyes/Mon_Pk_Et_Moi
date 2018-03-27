//
//  EmbedTratiementViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 16/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EmbedTratiementViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate {
    
   
    
    
    @IBOutlet weak var priseTableView: UITableView!
   
    @IBOutlet weak var nomMedicTextField: UITextField!
    
    @IBOutlet weak var doseTextField: UITextField!
    
    @IBOutlet weak var dateDebut: UITextField!
    
    @IBOutlet weak var dateFin: UITextField!
    
    let datePickerDebut = UIDatePicker()
    let datePickerFin = UIDatePicker()
    
    var traitement: Traitement? = nil
    
    var hourFormatter = DateFormatter()
    
    
   var alert = UIAlertController()
    
    
    
    var heurs: [NSDate] = []

    // MARK: - Handle add button
    @IBAction func ajouterprise(_ sender: Any) {
        
         let hourPicker  = UIDatePicker()
        hourPicker.datePickerMode = UIDatePickerMode.time
        hourPicker.addTarget(self, action: #selector(hourPickedValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        alert = UIAlertController(title: "Nouvelle prise",
                                      message: "Ajouter une nouvelle prise",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title : "Ajouter",
                                       style: .default)
        {
            [unowned self] action in
            guard let textField = self.alert.textFields?.first,
                let hourToSave = textField.text else {
                    return
            }
            self.heurs.append(self.hourFormatter.date(from: hourToSave)! as NSDate)
            self.priseTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Annuler",
                                         style: .default)
        let field = UITextField()
        field.inputView = hourPicker
        alert.addTextField()
        alert.textFields?.first?.inputView = hourPicker
        alert.textFields?.first?.text = self.hourFormatter.string(from: hourPicker.date)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true)
        
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourFormatter.dateFormat = "HH:mm"

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
        
 
        if let traitement = self.traitement
        {
            self.nomMedicTextField.text = traitement.concerne?.nomMedic
            self.doseTextField.text = String((traitement.concerne?.dose)!)
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy" //the format of the date that will be displayed
            
            self.dateDebut.text = formatter.string(for: traitement.dateDebut)
            self.dateFin.text = formatter.string(for: traitement.dateFin)
            
             if let heurs = traitement.estPrisA
            {
                for heursPrise in heurs
                {
                    if let h = heursPrise as? HeurPrise
                    {
                        self.heurs.append(h.heur!)
                    }
                }
            }
            
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
        
        
        dateFin.text = formatter.string(from: sender.date)
    }
    
    func hourPickedValueChanged(sender: UIDatePicker)
    {
        
        alert.textFields?.first?.text = hourFormatter.string(from: sender.date)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //MARK: - Date table view protocl
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.heurs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.priseTableView.dequeueReusableCell(withIdentifier: "hourCell", for: indexPath) as! HourTableViewCell
        
        cell.hourLabel.text = hourFormatter.string(for: self.heurs[indexPath.row])
        return cell
    }
    
    //MARK: data source protocol
     // tell if a particular row can be edited
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            self.priseTableView.beginUpdates()
            heurs.remove(at: indexPath.row)
            self.priseTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
         
            self.priseTableView.endUpdates()
            
        }
    }
    
    
    

}
