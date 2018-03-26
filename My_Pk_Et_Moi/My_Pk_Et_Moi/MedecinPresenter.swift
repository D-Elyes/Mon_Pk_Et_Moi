//
//  MedecinPresenter.swift
//  My_Pk_Et_Moi
//
//  Created by Amin BAZAZ on 26/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation

class MedecinPresenter: NSObject {
    fileprivate var nomMedecin : String = ""
    fileprivate var specialiteMedecin : String = ""
    fileprivate var telephoneMedecin : String = ""
    
    fileprivate var medecin : Medecin? = nil {
        didSet{
            if let medecin = self.medecin{
                if let nomTmp = medecin.nom{ self.nomMedecin = nomTmp.capitalized }
                else{ self.nomMedecin = "-"}
                
                if let speTmp = medecin.specialite{ self.specialiteMedecin = speTmp.capitalized }
                else{ self.specialiteMedecin = "-"}
                
                if let telTmp = medecin.telephone{ self.telephoneMedecin = telTmp.capitalized }
                else{ self.telephoneMedecin = "-"}
            }
            else{
                self.nomMedecin = ""
                self.specialiteMedecin = ""
                self.telephoneMedecin = ""
            }
        }
    }
    
    func configure(theCell : MedecinTableViewCell?, forMedecin: Medecin?){
        self.medecin = forMedecin
        guard let cell = theCell else { return }
        cell.nomMedLabel.text = self.nomMedecin
        cell.specialiteLabel.text = self.specialiteMedecin
        cell.telephoneLabel.text = self.telephoneMedecin
    }
}
