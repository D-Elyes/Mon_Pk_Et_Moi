//
//  Evaluation.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 24/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation
import CoreData

extension Evaluation{
    static func getAllEvaluation() -> NSFetchedResultsController<Evaluation>{
        let request : NSFetchRequest<Evaluation> = Evaluation.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Evaluation.concerneRdv.date),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        return fetchResultController
    }
    
    static func getAllJourEvaluation(evaluation : Evaluation) -> NSFetchedResultsController<JourEvaluation>{
        let request : NSFetchRequest<JourEvaluation> = JourEvaluation.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(JourEvaluation.jour),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        request.predicate = NSPredicate(format: "correspondreEvaluation == %@", evaluation)
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        return fetchResultController
    }
    
    static func getAllEtat(evaluation : Evaluation) -> NSFetchedResultsController<Etat>{
        let request : NSFetchRequest<Etat> = Etat.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Etat.heure),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        request.predicate = NSPredicate(format: "correspondreJourEvaluation.correspondreEvaluation == %@", evaluation)
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        return fetchResultController
    }
    
    static func getAllEvenement(evaluation : Evaluation) -> NSFetchedResultsController<Evenement>{
        let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Evenement.evenement),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        request.predicate = NSPredicate(format: "appartientAEva == %@", evaluation)
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        return fetchResultController
    }

}
