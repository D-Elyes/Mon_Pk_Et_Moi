//
//  EvaluationViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 17/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class EvaluationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    fileprivate lazy var evaluationFetched : NSFetchedResultsController<Evaluation> = Evaluation.getAllEvaluation()
    
    @IBOutlet weak var evaluationsTable: UITableView!
    
    @IBOutlet var evaluationPresenter: EvaluationPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.evaluationFetched.performFetch()
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
        self.evaluationsTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.evaluationsTable.endUpdates()
        CoreDataManager.save()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.evaluationsTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    
    // MARK: - Tableview Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let section = self.evaluationFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.evaluationsTable.dequeueReusableCell(withIdentifier: "evaluationCell", for: indexPath) as! EvaluationTableViewCell
        let evaluation = self.evaluationFetched.object(at: indexPath)
        self.evaluationPresenter.configureEvaluation(theCell: cell, forEvaluation: evaluation)
        return cell
    }
    

    // MARK: - Navigation
   
    let segueShowEvaluationId = "showEvaluationSegue"
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueShowEvaluationId{
            if let indexPath = self.evaluationsTable.indexPathForSelectedRow{
                let showEvaluationViewController = segue.destination as! ShowEvaluationViewController
                showEvaluationViewController.evaluation = self.evaluationFetched.object(at: indexPath)
                self.evaluationsTable.deselectRow(at: indexPath, animated: true)
            }
        }
    }

}
