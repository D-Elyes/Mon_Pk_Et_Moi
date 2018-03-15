//
//  addRdvViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 15/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class addRdvViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Mark : - Formulaire ajout sport : cancel/save

    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        guard let embedRdvViewController = self.childViewControllers[0] as? EmbedRdvViewController
            else {return}
        
        let lieuRdv : String = embedRdvViewController.lieuTextF.text ?? ""
        let medecinRdv : String = embedRdvViewController.medTextF.text ?? ""
        

        let dateRdv = embedRdvViewController.datePick.date
        
        
        let dateFormatterHeure = DateFormatter()
        dateFormatterHeure.locale = Locale(identifier: "fr_FR")
        dateFormatterHeure.dateFormat = "hh mm"
        let heureRdv = dateFormatterHeure.string(from: embedRdvViewController.heurePick.date)
        
        
        
        
        
        guard (lieuRdv != "" ) || (medecinRdv != "" ) else { return }
        // create a new Sports Managed Object
        let rdv = Rdv(context: CoreDataManager.context)
        // then modify it according to values
        rdv.date = dateRdv as NSDate
        rdv.heure = heureRdv
        rdv.lieu = lieuRdv
        rdv.concerneMedecin?.nom = medecinRdv
        
        
        self.dismiss(animated: true, completion: nil)
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
