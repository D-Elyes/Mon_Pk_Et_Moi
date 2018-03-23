//
//  ShowEtatViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 22/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class ShowEtatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet var etatPresenter: EvaluationPresenter!
    
    var evaluation : Evaluation? = nil

    @IBOutlet weak var etatsTable: UITableView!
    
    @IBOutlet weak var evenementTable: UITableView!
    
    func getEtatFetched() -> NSFetchedResultsController<Etat> {
        let request : NSFetchRequest<Etat> = Etat.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Etat.heure),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        request.predicate = NSPredicate(format: "correspondreJourEvaluation.correspondreEvaluation == %@", self.evaluation!)
        fetchResultController.delegate = self
        return fetchResultController
    }
    fileprivate lazy var etatFetched : NSFetchedResultsController<Etat> = self.getEtatFetched()
    
    func getEvenementFetched() -> NSFetchedResultsController<Evenement> {
        let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Evenement.evenement),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        request.predicate = NSPredicate(format: "appartientAEva == %@", self.evaluation!)
        fetchResultController.delegate = self
        return fetchResultController
    }
    fileprivate lazy var evenementFetched : NSFetchedResultsController<Evenement> = self.getEvenementFetched()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try self.etatFetched.performFetch()
            try self.evenementFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - NSFetchResultController delegate protocol
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.etatsTable.beginUpdates()
        self.evenementTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.etatsTable.endUpdates()
        self.evenementTable.endUpdates()
        CoreDataManager.save()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.etatsTable.insertRows(at: [newIndexPath], with: .fade)
                self.evenementTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    // MARK: - Tableview Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var count : Int?
        if tableView == self.etatsTable{
            guard let section = self.etatFetched.sections?[section] else {
                fatalError("unexpected section number")
            }
            count = section.numberOfObjects
        }
        
        if tableView == self.evenementTable{
            guard let section = self.evenementFetched.sections?[section] else {
                fatalError("unexpected section number")
            }
            count = section.numberOfObjects
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell : EtatTableViewCell? = nil
        if tableView == self.etatsTable{
            cell = self.etatsTable.dequeueReusableCell(withIdentifier: "etatCell", for: indexPath) as? EtatTableViewCell
            let etat = self.etatFetched.object(at: indexPath)
            self.etatPresenter.configureEtat(theCell: cell, forEtat: etat)
        }
        if tableView == self.evenementTable{
            cell = self.evenementTable.dequeueReusableCell(withIdentifier: "evenementCell", for: indexPath) as? EtatTableViewCell
            let evenement = self.evenementFetched.object(at: indexPath)
            self.etatPresenter.configureEvenement(theCell: cell, forEvenement: evenement)
        }
        return cell!
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
