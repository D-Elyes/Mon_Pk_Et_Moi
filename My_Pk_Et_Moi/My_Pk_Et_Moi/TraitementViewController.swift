//
//  TraitementViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 12/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class TraitementViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{

    @IBOutlet weak var traitementTableView: UITableView!
   
    
    @IBOutlet var TraitementPresenter: TraitementPresenter!
    //collection of medicaments to be displayed in self.traitementTableView
    //var traitement : [Traitement] = []
    
   
   fileprivate lazy var traitementFetched : NSFetchedResultsController<Traitement> =
    {
      // prepare a request
        let request : NSFetchRequest<Traitement> = Traitement.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Traitement.dateDebut), ascending: false)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        return fetchResultController
    }()
   
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //get the context
      //  let context = CoreDataManager.context
        
        //create request associated to Medicament entity
        //let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
        do
        {
          //  try self.medicaments = context.fetch(request)
            try self.traitementFetched.performFetch()
        }
        catch  let error as NSError
        {
            DialogBoxHelper.alert(view: self,error: error)
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
        if let error = CoreDataManager.save()
        {
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    /*
    /// Create a new Tratiement add it to the collection and save it
    ///
    /// - Parameter name: name of medicament to be added
    func saveNewTraitement(withName name: String, withDose dose: Int16, withDateDebut dateDebut: NSDate, withDateFin dateFin: NSDate, withQtteParJour qtteParJour: Int16, withNbrjourParSemaine nbrJourParSemaine: Int16 )
    {
        //get the context
        let context = CoreDataManager.context
        //create a Medicament managedObject
        let traitement = Traitement(context: context)
        
        //modify the medicament
       // Traitement.nomMedicament = name
       // Traitement.dose = dose
        traitement.dateDebut = dateDebut
        traitement.dateFIn = dateFin
        
        
        do
        {
            try context.save()
            self.medicaments.append(traitement)
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view: self,error: error)
            return
        }
    }*/
  
    
    // MARK: - TableView data source protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //return self.medicaments.count
        guard let section = self.traitementFetched.sections?[section] else
        {
            fatalError("unexpected section number")
        }
        
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.traitementTableView.dequeueReusableCell(withIdentifier: "traitementCell",for: indexPath) as! TraitementTableViewCell
        
        let traitement = self.traitementFetched.object(at: indexPath)
        self.TraitementPresenter.configure(theCell: cell, forTraitement:  traitement)
       //self.TraitementPresenter.configure(theCell: cell, forMedicament: self.medicaments[indexPath.row])
        
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
    
    //MARK: - Action Handler
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void
    {
        let traitement = self.traitementFetched.object(at: indexPath)
        CoreDataManager.context.delete(traitement)
        //self.traitementTableView.beginUpdates()
        /*if self.delete(medicamentWithIndex: indexPath.row)
        {
            self.traitementTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        self.traitementTableView.endUpdates()*/
    }
    
    func editHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void
    {
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueEditTraitementId, sender: self)
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
    /*func delete(medicamentWithIndex index : Int)-> Bool
    {
        let context = CoreDataManager.context
        let medicament = self.medicaments[index]
        context.delete(medicament)
        do{
            try context.save()
            self.medicaments.remove(at: index)
            return true
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view: self,error: error)
            return false
        }
        
    }
    */
   
    
    // MARK: - helper methote -
    
   
    /// get context of core data initialized in application delegate
    ///
    /// - Parameters:
    ///   - errorMsg: main error message
    ///   - userInfo: additional information user want to display
    /// - Returns: context of Coredata
   /* func getContext(errorMsg: String, userInfo: String = "could not retrieve data context" ) -> NSManagedObjectContext?
    {
        //get context of persistent data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            DialogBoxHelper.alert(view: self,withTitle: errorMsg, andMessage: userInfo)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
        
    }*/
  
    // MARK: - TableView Delegate protocol
    
    var indexPathForShow : IndexPath? = nil
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueShowTraitementId, sender: self)
    }
    
    //MARK - NSFetchResultController delegare protocl
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.traitementTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.traitementTableView.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .delete:
            if let indexPath = indexPath
            {
                self.traitementTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath
            {
                self.traitementTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath, let cell = self.traitementTableView.cellForRow(at: indexPath) as? TraitementTableViewCell
            {
                let traitement = self.traitementFetched.object(at: indexPath)
                self.TraitementPresenter.configure(theCell: cell, forTraitement:  traitement)
            }
        default:
            break
        }
    }
    
    
    // MARK: - Navigation
    
    let segueShowTraitementId = "showTraitementSegue"
    let segueEditTraitementId = "editTraitementSegue"

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueShowTraitementId
        {
            
            if let indexPath = self.indexPathForShow
            {
            
                let showTraitementViewController = segue.destination as! ShowTraitementViewController
                showTraitementViewController.traitement = self.traitementFetched.object(at: indexPath)
                self.traitementTableView.deselectRow(at: indexPath, animated: true)
                indexPathForShow = nil
            }
            else if let indexPath = self.traitementTableView.indexPathForSelectedRow
            {
                let showTraitementViewController = segue.destination as! ShowTraitementViewController
                showTraitementViewController.traitement = self.traitementFetched.object(at: indexPath)
                self.traitementTableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        if segue.identifier == self.segueEditTraitementId
        {
            if let indexPath = self.indexPathForShow
            {
                let editTraitementViewController = segue.destination as! EditTraitementViewController
                editTraitementViewController.traitement = self.traitementFetched.object(at: indexPath)
                
                
            }
        }
    }
    
   // @IBAction func unwindToTratiementListAfterSavingNewTraitement(segue: UIStoryboardSegue)
   //{
    
           
        /*let newTraitementController = segue.source as! NewTraitementViewController
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
        
        self.traitementTableView.reloadData()*/
   // }
    
    @IBAction func unwindToTratiementListAfterEditingTraitement(segue: UIStoryboardSegue)
     {
       // self.save()
        //self.traitementTableView.reloadData()
    }
        
    
        
        

}
