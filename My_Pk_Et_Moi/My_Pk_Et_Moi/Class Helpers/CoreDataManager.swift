//
//  CoreDataManager.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 17/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject
{
    
    /// get context from application
    ///
    /// - Returns: 'NSManagedObjectContext' of core data initialized in application delegate
    static var context : NSManagedObjectContext =
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            exit(EXIT_FAILURE)
            
        }
        return appDelegate.persistentContainer.viewContext
        
    }()
    
    @discardableResult
    class func save() -> NSError?
    {
        //try to save
        do
        {
            try CoreDataManager.context.save()
            return nil
        }
        catch let error as NSError
        {
            return error
        }
    }
}

