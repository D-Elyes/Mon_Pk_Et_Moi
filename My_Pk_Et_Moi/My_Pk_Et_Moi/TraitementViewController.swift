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
    
    //collection of medicaments to be displayed in self.traitementTableView
    var medicaments : [Medicament] = []
    
    /// called when add button is pressed
    ///
    ///Display a dialog that allow the user to enter a name of medicament, AFter the name entered
    ///a new Medicament will be created and added to the list
    /// - Parameter sender: object that trigger action
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
            self.saveNewTraitement(withName : nameToSave)
            self.traitementTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Annuler",
                                         style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }*/
    
    
    // MARK: - Tratiement data management -
    
    /// Create a new Tratiement add it to the collection and save it
    ///
    /// - Parameter name: name of medicament to be added
    func saveNewTraitement(withName name: String, withDose dose: Int16, withDateDebut dateDebut: NSDate, withDateFin dateFin: NSDate, withQtteParJour qtteParJour: Int16, withNbrjourParSemaine nbrJourParSemaine: Int16 )
    {
        //get the context
        guard let context = self.getContext(errorMsg: "save failed") else {return}
        //create a Medicament managedObject
        let medicament = Medicament(context: context)
        
        //modify the medicament
        medicament.nomMedicament = name
        medicament.dose = dose
        medicament.dateDebut = dateDebut
        medicament.dateFIn = dateFin
        medicament.nbParJour = qtteParJour
        medicament.nbJourParSemaine = nbrJourParSemaine
        
        
        do
        {
            try context.save()
            self.medicaments.append(medicament)
        }
        catch let error as NSError
        {
            self.alert(error: error)
            return
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //get the context
        guard let context = self.getContext(errorMsg: "could not load data") else{return}
        
        //create request associated to Medicament entity
        let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
        do
        {
            try self.medicaments = context.fetch(request)
        }
        catch  let error as NSError
        {
            self.alert(error: error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TableView data source protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.medicaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.traitementTableView.dequeueReusableCell(withIdentifier: "medicCell",for: indexPath) as! MedicamentTableViewCell
        
        
        //cell.medicNameLabel.text = self.names[indexPath.row]
        cell.medicNameLabel.text = self.medicaments[indexPath.row].nomMedicament
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" //the format of the date that will be displayed
        cell.startDateLabel.text = formatter.string(for: self.medicaments[indexPath.row].dateDebut)
        cell.endDateLabel.text = formatter.string(for: self.medicaments[indexPath.row].dateFIn)
        
        
        return cell
        
    }
    
    // MARK: - helper methote -
    
   
    /// get context of core data initialized in application delegate
    ///
    /// - Parameters:
    ///   - errorMsg: main error message
    ///   - userInfo: additional information user want to display
    /// - Returns: context of Coredata
    func getContext(errorMsg: String, userInfo: String = "could not retrieve data context" ) -> NSManagedObjectContext?
    {
        //get context of persistent data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            self.alert(withTitle: errorMsg, andMessage: userInfo)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
        
    }
    
    /// show an alert dialog box with two message
    ///
    /// - Parameters:
    ///   - title: title of dialog box seen as main message
    ///   - msg: additional message used to describe context or additional information
    func alert(withTitle title: String, andMessage msg: String = "")
    {
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    /// shows an alert to inform about an error
    ///
    /// - Parameter error: error we want information about
    func alert(error: NSError)
    {
        self.alert(withTitle: "\(error)", andMessage: "\(error.userInfo)")
    }
    
    
    // MARK: - Navigation
    
    let segueShowMedicId = "showMedicSegue"

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueShowMedicId
        {
            if let indexPath = self.traitementTableView.indexPathForSelectedRow
            {
                let showMedicamentViewController = segue.destination as! ShowMedicViewController
                showMedicamentViewController.medicament = self.medicaments[indexPath.row]
                self.traitementTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindToTratiementListAfterSavingNewTraitement(segue: UIStoryboardSegue)
    {
        let newTraitementController = segue.source as! NewTraitementViewController
       
        let nomMedic =  newTraitementController.nomMedicTextField.text!
        
        
        let dose = Int16(newTraitementController.doseTextField!.text!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let dateDebut = dateFormatter.date(from: newTraitementController.dateDebut.text!) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        guard let dateFin = dateFormatter.date(from: newTraitementController.dateFin.text!) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        
        let nbParJour = Int16(newTraitementController.qtteParJourTextField!.text!)
        let nbJourParSemaine = Int16(newTraitementController.jourParSemaineTextField!.text!)
        
        self.saveNewTraitement(withName: nomMedic, withDose: dose!, withDateDebut: dateDebut as NSDate, withDateFin: dateFin as NSDate, withQtteParJour: nbParJour!, withNbrjourParSemaine: nbJourParSemaine!)
        
        self.traitementTableView.reloadData()
    }
    

}
