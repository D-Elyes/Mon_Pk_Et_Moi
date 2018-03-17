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
    
    @IBOutlet var rdvPresenter: RdvPresenter!
    var indexPathForShow: IndexPath? = nil
    
    
    @IBOutlet weak var rdvTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.rdvFetched.performFetch()
        }
        catch let error as NSError{
            
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
        self.rdvPresenter.configure(theCell: cell, forRdv: rdv)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Effacer", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor.red
        return[delete/*, edit*/]
    }
    
    
    // MARK: - Action Handler
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let rdv = self.rdvFetched.object(at: indexPath)
        CoreDataManager.context.delete(rdv)
    }
    
    
    // MARK: - Navigation
    
    /*// In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }*/

}
