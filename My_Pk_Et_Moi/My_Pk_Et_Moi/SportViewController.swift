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
    
    
    // MARK: - NSDetchResultController delegate protocol
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.sportsTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.sportsTable.endUpdates()
    }
    
    
    // MARK: - Navigation

    let segueShowSportId = "showSportSegue"
    
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
    
    @IBAction func unwindToSportsListAfterSavingNewSport(segue: UIStoryboardSegue){
        //let jour = "lundi" // à modifier !!!!!!
        //let heur = "10h00" // à modifier !!!!!!
        
        /*guard let nomField = nomSport.text, let typeField = typeTextF.text, let objField = objectif.text else { //a modifier !
         // afficher pop erreur formulaire
         return
         }
         self.saveNewSport(nomSport: nomField, typeSport: typeField, objSport: objField) //à compléter !!!!!!!!!*/
        
    }


}
