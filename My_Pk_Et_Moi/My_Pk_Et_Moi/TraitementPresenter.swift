//
//  TraitementPresenter.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 16/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation
import CoreData


class TraitementPresenter : NSObject
{
    fileprivate var medicName: String = ""
    fileprivate var dateDabut :  Date = Date()
    fileprivate var dateFin : Date = Date()
    
    
    fileprivate var traitement : Traitement? = nil
    {
        didSet
        {
            if let traitement = self.traitement
            {
                if let medicName = traitement.concerne?.nomMedic
                {
                    self.medicName = medicName
                }
                else
                {
                    self.medicName = " - "
                }
                
                
                
                if let medicDateDebut = traitement.dateDebut
                {
                    self.dateDabut =  medicDateDebut as Date
                }
                else
                {
                    self.dateDabut = Date()
                }
                
                
                if let medicDateFin = traitement.dateFin
                {
                    self.dateFin = medicDateFin as Date
                }
                else
                {
                    self.dateFin = Date()
                }
                
        
                
            }
            else
            {
                self.medicName = ""
                self.dateDabut =  Date()
                self.dateFin = Date()
            }
        }
    }
    
    func configure(theCell : TraitementTableViewCell?, forTraitement: Traitement? )
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        self.traitement = forTraitement
        guard let cell = theCell else {return}
        cell.medicNameLabel.text = self.medicName
        cell.startDateLabel.text = formatter.string(from: self.dateDabut)
        cell.endDateLabel.text = formatter.string(from: self.dateFin)
    }
}
