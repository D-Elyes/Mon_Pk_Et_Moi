//
//  TraitementViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 12/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class TraitementViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var traitementTableView: UITableView!
    
    var names : [String] = ["Panadol","Grippex"]
   // var medicaments : [Medicament] = []
    
    /*@IBAction func addTraitement(_ sender: Any) {
        let alert = UIAlertController(title: "Nouveau Traitement",
                                      message: "Ajouter un traitement",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Ajouter",
                                       style: .default)
        {
            [unowned self ] action in
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else
            {
                return
            }
            self.names.append(nameToSave)
            self.traitementTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Annuler",
                                         style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.traitementTableView.dequeueReusableCell(withIdentifier: "medicCell",for: indexPath) as! MedicamentTableViewCell
        
        
        cell.medicNameLabel.text = self.names[indexPath.row]
        /*cell.medicNameLabel.text = self.medicaments[indexPath.row].nomMedicament
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" //the format of the date that will be displayed
        cell.startDateLabel.text = formatter.string(for: self.medicaments[indexPath.row].dateDebut)
        cell.endDateLabel.text = formatter.string(for: self.medicaments[indexPath.row].dateFIn)
        */
        return cell
        
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
