//
//  CoreDataManager.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 12/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CoreDataManager: NSObject {
    // get context into application delegate
    static var context : NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            exit(EXIT_FAILURE) // faire le message d'erreur
        }
        return appDelegate.persistentContainer.viewContext
    }()
}
