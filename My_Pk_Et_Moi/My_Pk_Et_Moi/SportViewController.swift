//
//  SportViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 07/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class SportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //var nomSport : [String] = ["Amin"]
    var sports : [Activite] = []

    @IBOutlet weak var sportsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get context into application delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            // faire le message d'erreur
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        //create a request associate to Sport
        let request : NSFetchRequest<Activite> = Activite.fetchRequest()
        do{
            try self.sports = context.fetch(request)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.sportsTable.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! SportTableViewCell
        cell.nomlabel.text = self.sports[indexPath.row].nom
        return cell
    }

}
