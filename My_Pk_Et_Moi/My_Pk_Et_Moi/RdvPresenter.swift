//
//  RdvPresenter.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 16/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import UIKit
import Foundation

class RdvPresenter: NSObject {
    fileprivate var dateRdv : NSDate?
    fileprivate var lieuRdv : String = ""
    fileprivate var heureRdv : String = ""
    fileprivate var medecinRdv : String = ""
    
    fileprivate var rdv : Rdv? = nil {
        didSet{
            if let rdv = self.rdv{
                if let dateTmp = rdv.date{ self.dateRdv = dateTmp }
                else{ self.dateRdv = nil}
                
                if let lieuTmp = rdv.lieu{ self.lieuRdv = lieuTmp.capitalized }
                else{ self.lieuRdv = "-"}
                
                if let heureTmp = rdv.heure{ self.heureRdv = heureTmp.capitalized }
                else{ self.heureRdv = "-"}
                
                /*if let medecinTmp = rdv.concerneMedecin?.nom{ self.medecinRdv = medecinTmp.capitalized }
                else{ self.medecinRdv = "-"}*/
            }
            else{
                self.dateRdv = nil
                self.lieuRdv = ""
                self.heureRdv = ""
                self.medecinRdv = ""
            }
        }
    }
    
    func configure(theCell : RdvTableViewCell?, forRdv: Rdv?){
        self.rdv = forRdv
        guard let cell = theCell else { return }
        //cell.dateLabel.text = self.dateRdv
        cell.lieuLabel.text = self.lieuRdv
        cell.heureLabel.text = self.heureRdv
        cell.medecinLabel.text = self.medecinRdv
    }
}
