//
//  File.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 19/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation
import CoreData

extension Rdv{
    static func getAllRdv() -> NSFetchedResultsController<Rdv>{
        let request : NSFetchRequest<Rdv> = Rdv.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Rdv.date),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
        return fetchResultController
    }
    
    
    func convertDate(dateModify : NSDate) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: dateModify as Date)
    }
}
