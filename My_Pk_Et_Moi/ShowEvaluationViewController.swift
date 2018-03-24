//
//  ShowEvaluationViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 21/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class ShowEvaluationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    
    var evaluation : Evaluation? = nil
    
    @IBOutlet var jourEvaluationPresenter: EvaluationPresenter!
    
    
    fileprivate lazy var joursEvaluationFetched : NSFetchedResultsController<JourEvaluation> = Evaluation.getAllJourEvaluation(evaluation: self.evaluation!)

    @IBOutlet weak var joursEvaluationTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.joursEvaluationFetched.performFetch()
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
        self.joursEvaluationTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.joursEvaluationTable.endUpdates()
        CoreDataManager.save()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.joursEvaluationTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }

    
    // MARK: - Tableview Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let section = self.joursEvaluationFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.joursEvaluationTable.dequeueReusableCell(withIdentifier: "jourEvaluationCell", for: indexPath) as! JourEvaluationTableViewCell
        let joursEvaluation = self.joursEvaluationFetched.object(at: indexPath)
        self.jourEvaluationPresenter.configureJourEvaluation(theCell: cell, forJourEvaluation: joursEvaluation)
        return cell
    }
    
    // MARK: - Navigation
    
    let segueAddEvaluationId = "addEvaluationSegue"
    let segueShowEtatId = "showEtatSegue"
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueAddEvaluationId{
            if let evaluationTmp = self.evaluation{
                let addEvaluationViewController = segue.destination as! AddEvaluationViewController
                addEvaluationViewController.evaluation = evaluationTmp
            }
        }
        if segue.identifier == self.segueShowEtatId{
            if let evaluationTmp = self.evaluation{
                let showEtatViewController = segue.destination as! ShowEtatViewController
                showEtatViewController.evaluation = evaluationTmp
            }
        }
    }

}
