//
//  MedecinViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 26/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import CoreData

class MedecinViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    fileprivate lazy var medecinFetched : NSFetchedResultsController<Medecin> = {
        let request : NSFetchRequest<Medecin> = Medecin.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Medecin.nom),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    //Handle presentation of cell in the table view
    @IBOutlet var medecinPresenter: MedecinPresenter!
    
    var pickerView = UIPickerView()
    
    //Medecins contains all sepeciality
    let medecins : [String] = ["Psychiatre","Neurologue","Gériatre","Neurochirurgien","Gastro-entérologue","Urologue","Ophtalmologiste","ORL-phoniatre","Rhumatologue","Pneumologue","Cardiologue","Chirurgien-dentiste"]
    
    @IBOutlet weak var medecinTable: UITableView!
    
    @IBOutlet weak var nomTf: UITextField!
    @IBOutlet weak var specialiteTf: UITextField!
    @IBOutlet weak var telephoneTf: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.medecinFetched.performFetch()
            
            specialiteTf.inputView = pickerView
            specialiteTf.textAlignment = .center
            specialiteTf.placeholder = "Selection spécialité"
            specialiteTf.text = medecins[0]
            
            pickerView.delegate = self
            pickerView.dataSource = self
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
        self.medecinTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.medecinTable.endUpdates()
        CoreDataManager.save()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.medecinTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.medecinTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    // MARK: - TextField Delegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    // MARK: - Tableview Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let section = self.medecinFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.medecinTable.dequeueReusableCell(withIdentifier: "medecinCell", for: indexPath) as! MedecinTableViewCell
        let medecin = self.medecinFetched.object(at: indexPath)
        self.medecinPresenter.configure(theCell: cell, forMedecin: medecin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Effacer", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor.red
        return[delete/*, edit*/]
    }
    
    
    // MARK: - Action Handler
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let medecin = self.medecinFetched.object(at: indexPath)
        CoreDataManager.context.delete(medecin)
    }
    
    // MARK: - PickerView Delegate
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return medecins.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medecins[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        specialiteTf.text = medecins[row]
        specialiteTf.resignFirstResponder()
    }
    
    
    // MARK: - Handle add button medecin
    
    @IBAction func addMedecin(_ sender: Any) {

        let nomMedecin : String = self.nomTf.text ?? ""
        let speMedecin : String = self.specialiteTf.text ?? ""
        let telMedecin : String = self.telephoneTf.text ?? ""
        
        
        guard (nomMedecin != "" ) || (speMedecin != "" ) || (telMedecin != "" ) else {
            DialogBoxHelper.alert(view: self, withTitle: "Champs manquants", andMessage: "Formulaire incomplet")
            return
        }
        // create a new Sports Managed Object
        let medecin = Medecin(context: CoreDataManager.context)
        // then modify it according to values
        medecin.nom = nomMedecin
        medecin.specialite = speMedecin
        medecin.telephone = telMedecin
        CoreDataManager.save()
        medecinTable.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
