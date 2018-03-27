//
//  Medecin.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 26/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation
import CoreData

extension Medecin{
    static func getAllMedecin() -> NSFetchedResultsController<Medecin>{
        let request : NSFetchRequest<Medecin> = Medecin.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Medecin.nom),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        return fetchResultController
    }
    
    static func getAllSpeciality() -> [String]{
        var medecins : [Medecin] = []
        var specialite : [String] = []
        let request : NSFetchRequest<Medecin> = Medecin.fetchRequest()
        //let medecinFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Medecin")
        do{
            try medecins = CoreDataManager.context.fetch(request)
        }
        catch{
        }
        if medecins.count > 0{
            for i in medecins{
                specialite.append(i.specialite!)
            }
        }
        return specialite
    }
    
}
