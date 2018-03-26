//
//  Activite.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 24/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation
import CoreData

extension Activite{
    static func getAllActivity() -> NSFetchedResultsController<Activite>{
        let request : NSFetchRequest<Activite> = Activite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Activite.nom),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        return fetchResultController
    }
}
