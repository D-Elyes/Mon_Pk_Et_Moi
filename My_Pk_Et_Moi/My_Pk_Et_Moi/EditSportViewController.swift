//
//  EditSportViewController.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 13/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit

class EditSportViewController: UIViewController {

    var sport : Activite? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard (self.sport != nil) else { return }
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveAction))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    let segueEmbedId = "embedFromEditSportSegue"
    let segueUnwindId = "unwindToSportViewControllerFromEditing"
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueEmbedId{
            let embedController = segue.destination as! EmbedSportViewController
            embedController.sport = self.sport
        }
    }
    

}
