//
//  RdvViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 15/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class RdvViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    fileprivate lazy var rdvFetched : NSFetchedResultsController<Rdv> = {
        let request : NSFetchRequest<Rdv> = Rdv.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Rdv.date),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    var indexPathForShow: IndexPath? = nil
    
    //@IBOutlet var sportPresenter: SportPresenter!
    @IBOutlet weak var rdvTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.rdvFetched.performFetch()
        }
        catch let error as NSError{
            // traiter l'erreur
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - NSFetchResultController delegate protocol
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.rdvTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.rdvTable.endUpdates()
        CoreDataManager.save()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.rdvTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.rdvTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    
    // MARK: - Navigation
    
    //let segueShowSportId = "showSportSegue"
    //let segueEditSportId = "editSportSegue"
    
    /*// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueShowSportId{
            if let indexPath = self.rdvTable.indexPathForSelectedRow{
                let ShowSportViewController = segue.destination as! ShowSportViewController
                ShowSportViewController.sport = self.sportsFetched.object(at: indexPath)
                self.sportsTable.deselectRow(at: indexPath, animated: true)
            }
        }
        if segue.identifier == self.segueEditSportId{
            if let indexPath = self.indexPathForShow{
                let editSportViewController = segue.destination as! EditSportViewController
                editSportViewController.sport = self.sportsFetched.object(at: indexPath)
            }
        }
    }*/
    
    
    // MARK: - Tableview Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let section = self.rdvFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.rdvTable.dequeueReusableCell(withIdentifier: "rdvCell", for: indexPath) as! RdvTableViewCell
        let rdv = self.rdvFetched.object(at: indexPath)
        //self.sportPresenter.configure(theCell: cell, forSport: sport)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Effacer", handler: self.deleteHandlerAction)
        //let edit = UITableViewRowAction(style: .default, title: "Modifier", handler: self.editHandlerAction)
        delete.backgroundColor = UIColor.red
        //edit.backgroundColor = UIColor.blue
        return[delete/*, edit*/]
    }
    
    
    
    
    // MARK: - Action Handler
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let sport = self.rdvFetched.object(at: indexPath)
        CoreDataManager.context.delete(sport)
    }
    
    /*func editHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueEditSportId, sender: self)
        self.rdvTable.setEditing(false, animated: true)
    }*/

}
