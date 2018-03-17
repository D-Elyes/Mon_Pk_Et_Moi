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
   
    
    @IBOutlet var TraitementPresenter: TraitementPresenter!
    //collection of medicaments to be displayed in self.traitementTableView
    var medicaments : [Medicament] = []
    
   
    
   
    
  
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
    
    //MARK: - Traitement data management
    
    /// save data
    func save()
    {
        //get context into application delegate
        guard let context = self.getContext(errorMsg: "Save failed") else {return}
        do
        {
            try context.save()
        }
        catch let error as NSError
        {
            self.alert(error: error)
            return
        }
    }
    
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
  
    
    // MARK: - TableView data source protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.medicaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.traitementTableView.dequeueReusableCell(withIdentifier: "medicCell",for: indexPath) as! MedicamentTableViewCell
        
        self.TraitementPresenter.configure(theCell: cell, forMedicament: self.medicaments[indexPath.row])
        
        //cell.medicNameLabel.text = self.names[indexPath.row]
        /*cell.medicNameLabel.text = self.medicaments[indexPath.row].nomMedicament
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" //the format of the date that will be displayed
        cell.startDateLabel.text = formatter.string(for: self.medicaments[indexPath.row].dateDebut)
        cell.endDateLabel.text = formatter.string(for: self.medicaments[indexPath.row].dateFIn)*/
        cell.accessoryType = .detailButton
        
        return cell
        
    }
    
    // tell if a particular row can be edited
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void
    {
        self.traitementTableView.beginUpdates()
        if self.delete(medicamentWithIndex: indexPath.row)
        {
            self.traitementTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        self.traitementTableView.endUpdates()
    }
    
    func editHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void
    {
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueEditMedicId, sender: self)
        self.traitementTableView.setEditing(false, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Del", handler: self.deleteHandlerAction)
        let edit = UITableViewRowAction(style: .default, title: "Edit", handler: self.editHandlerAction)
        delete.backgroundColor = UIColor.red
        edit.backgroundColor = UIColor.blue
        return [delete,edit]
    }
    
    /// delete a medicament fromcollection according to its index
    ///
    /// - Precondition: Index must be into bound of collection
    /// - Parameter traitementWithIndex: index of traitement to delete
    /// - Returns: true if deletion succeded, else false
    func delete(medicamentWithIndex index : Int)-> Bool
    {
        guard let context = self.getContext(errorMsg: "Could not delete Traitement") else {return false}
        let medicament = self.medicaments[index]
        context.delete(medicament)
        do{
            try context.save()
            self.medicaments.remove(at: index)
            return true
        }
        catch let error as NSError
        {
            self.alert(error: error)
            return false
        }
        
    }
    
   
    //manage editing of a row
   /* func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //manage deleting
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
            self.traitementTableView.beginUpdates()
            if self.delete(medicamentWithIndex: indexPath.row)
            {
                self.traitementTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            self.traitementTableView.endUpdates()
        }
    }*/
    
    
    
    
    
    
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
    
    // Marks: - TableView Delegate protocol
    
    var indexPathForShow : IndexPath? = nil
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueShowMedicId, sender: self)
    }
    
    
    // MARK: - Navigation
    
    let segueShowMedicId = "showMedicSegue"
    let segueEditMedicId = "editMedicSegue"

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueShowMedicId
        {
            if let indexPath = self.indexPathForShow
            {
                let showMedicamentViewController = segue.destination as! ShowMedicViewController
                showMedicamentViewController.medicament = self.medicaments[indexPath.row]
                self.traitementTableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if segue.identifier == self.segueEditMedicId
        {
            if let indexPath = self.indexPathForShow
            {
                let editMedicViewController = segue.destination as! EditMedicViewController
                editMedicViewController.medicament = self.medicaments[indexPath.row]
                
                
            }
        }
    }
    
    @IBAction func unwindToTratiementListAfterSavingNewTraitement(segue: UIStoryboardSegue)
    {
        let newTraitementController = segue.source as! NewTraitementViewController
        let embedTraitementController = newTraitementController.childViewControllers[0] as! EmbedTratiementViewController
        let nomMedic =  embedTraitementController.nomMedicTextField.text!
        
        
        let dose = Int16(embedTraitementController.doseTextField!.text!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let dateDebut = dateFormatter.date(from: embedTraitementController.dateDebut.text!) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        guard let dateFin = dateFormatter.date(from: embedTraitementController.dateFin.text!) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        
        let nbParJour = Int16(embedTraitementController.qtteParJourTextField!.text!)
        let nbJourParSemaine = Int16(embedTraitementController.jourParSemaineTextField!.text!)
        
        self.saveNewTraitement(withName: nomMedic, withDose: dose!, withDateDebut: dateDebut as NSDate, withDateFin: dateFin as NSDate, withQtteParJour: nbParJour!, withNbrjourParSemaine: nbJourParSemaine!)
        
        self.traitementTableView.reloadData()
    }
    
     @IBAction func unwindToTratiementListAfterEditingTraitement(segue: UIStoryboardSegue)
     {
        self.save()
        self.traitementTableView.reloadData()
    }
        
    
        
        

}
