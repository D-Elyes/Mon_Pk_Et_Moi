//
//  SportViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 07/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class SportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    
    //var sports : [Activite] = []
    
    fileprivate lazy var sportsFetched : NSFetchedResultsController<Activite> = {
        let request : NSFetchRequest<Activite> = Activite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Activite.nom),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    var indexPathForShow: IndexPath? = nil
    
    @IBOutlet var sportPresenter: SportPresenter!
    @IBOutlet weak var sportsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.sportsFetched.performFetch()
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
        self.sportsTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.sportsTable.endUpdates()
        CoreDataManager.save()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.sportsTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.sportsTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    
    // MARK: - Navigation

    let segueShowSportId = "showSportSegue"
    let segueEditSportId = "editSportSegue"
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueShowSportId{
            if let indexPath = self.sportsTable.indexPathForSelectedRow{
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
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return self.sports.count
        guard let section = self.sportsFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.sportsTable.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! SportTableViewCell
        let sport = self.sportsFetched.object(at: indexPath)
        self.sportPresenter.configure(theCell: cell, forSport: sport)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Effacer", handler: self.deleteHandlerAction)
        let edit = UITableViewRowAction(style: .default, title: "Modifier", handler: self.editHandlerAction)
        delete.backgroundColor = UIColor.red
        edit.backgroundColor = UIColor.blue
        return[delete, edit]
    }
    
    func saveNewSport(nomSport nom: String, typeSport type: String, objSport obj: String){ // à modifier !!!!!!!!
        // get context into application delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            // faire le message d'erreur
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        //create a sport
        let sport = Activite(context: context)
        sport.nom = nom
        sport.type = type
        sport.objectif = obj
        do{
            try context.save()
        }
        catch let error as NSError{
            // completer l'erreur
            return
        }
    }
    

    // MARK: - Action Handler
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let sport = self.sportsFetched.object(at: indexPath)
        CoreDataManager.context.delete(sport)
    }
    
    func editHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueEditSportId, sender: self)
        self.sportsTable.setEditing(false, animated: true)
    }
    
    
    @IBAction func unwindToSportsListAfterSavingNewSport(segue: UIStoryboardSegue){
        //let jour = "lundi" // à modifier !!!!!!
        //let heur = "10h00" // à modifier !!!!!!
        
        let ajoutSportController = segue.source as! ajoutSportViewController
        let embedSportController = ajoutSportController.childViewControllers[0] as! EmbedSportViewController
        let nomSport = embedSportController.nomSport.text ?? ""
        let typeSport = embedSportController.typeTextF.text ?? ""
        let objSport = embedSportController.objectif.text ?? ""
        self.saveNewSport(nomSport: nomSport, typeSport: typeSport, objSport: objSport) //à compléter !!!!!!!!!
        self.sportsTable.reloadData()
    }
    


}
