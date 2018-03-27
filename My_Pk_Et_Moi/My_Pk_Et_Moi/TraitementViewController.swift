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
    
    @IBAction func unwindToTratiementListAfterEditingTraitement(segue: UIStoryboardSegue)
     {
       // self.save()
        //self.traitementTableView.reloadData()
    }
        
    
        
        

}
