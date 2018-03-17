//
//  TraitementPresenter.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 16/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation


class TraitementPresenter : NSObject
{
    fileprivate var medicName: String = ""
    fileprivate var dose : Int16 = 0
    fileprivate var dateDabut :  Date = Date()
    fileprivate var dateFin : Date = Date()
    fileprivate var qtteParjour : Int16 = 0
    fileprivate var nbrJourParSemaine : Int16 = 0
    
    fileprivate var medicament : Medicament? = nil
    {
        didSet
        {
            if let medicament = self.medicament
            {
                if let medicName = medicament.nomMedicament
                {
                    self.medicName = medicName
                }
                else
                {
                    self.medicName = " - "
                }
                
                
                if let medicDose = Int16?(medicament.dose)
                {
                    self.dose = medicDose
                }
                else
                {
                    self.dose = 0
                }
                
                
                if let medicDateDebut = medicament.dateDebut
                {
                    self.dateDabut =  medicDateDebut as Date
                }
                else
                {
                    self.dateDabut = Date()
                }
                
                
                if let medicDateFin = medicament.dateFIn
                {
                    self.dateFin = medicDateFin as Date
                }
                else
                {
                    self.dateFin = Date()
                }
                
                
                if let medicQtteParJour = Int16?(medicament.nbParJour)
                {
                    self.qtteParjour = medicQtteParJour
                }
                else
                {
                    self.qtteParjour = 0
                }
                
                
                if let medicNbrJourParSemaine = Int16?(medicament.nbJourParSemaine)
                {
                    self.nbrJourParSemaine = medicNbrJourParSemaine
                }
                else
                {
                    self.nbrJourParSemaine = 0
                }
                
                
            }
            else
            {
                self.medicName = ""
                self.dose = 0
                self.dateDabut =  Date()
                self.dateFin = Date()
                self.qtteParjour = 0
                self.nbrJourParSemaine  = 0
            }
        }
    }
    
    func configure(theCell : MedicamentTableViewCell?, forMedicament: Medicament? )
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        self.medicament = forMedicament
        guard let cell = theCell else {return}
        cell.medicNameLabel.text = self.medicName
        cell.startDateLabel.text = formatter.string(from: self.dateDabut)
        cell.endDateLabel.text = formatter.string(from: self.dateFin)
    }
}
