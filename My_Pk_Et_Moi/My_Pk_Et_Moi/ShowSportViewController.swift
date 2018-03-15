//
//  ShowSportViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 12/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class ShowSportViewController: UIViewController {

    @IBOutlet weak var jourLabel: UILabel!
    @IBOutlet weak var heureLabel: UILabel!
    @IBOutlet weak var objLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nomLabel: UILabel!
    
    var sport : Activite? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Si personne n'est pas vide
        if let sportTmp = self.sport{
            self.nomLabel.text = sportTmp.nom
            self.typeLabel.text = sportTmp.type
            self.objLabel.text = sportTmp.objectif
            self.heureLabel.text = sportTmp.heure
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
 

}
