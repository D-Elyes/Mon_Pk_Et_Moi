//
//  EvaluationPresenter.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 18/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation
import UIKit

class EvaluationPresenter: NSObject {
    fileprivate var dateRdv : NSDate?
    fileprivate var heureRdv : String = ""
    fileprivate var jourEval : String = ""
    fileprivate var heureEtat : String = ""
    fileprivate var etatRep : String = ""
    fileprivate var evenementRep : String = ""
    
    fileprivate var evaluation : Evaluation? = nil {
        didSet{
            if let evaluation = self.evaluation{
                if let dateTmp = evaluation.concerneRdv?.date{ self.dateRdv = dateTmp }
                else{ self.dateRdv = nil}
                
                if let heureTmp = evaluation.concerneRdv?.heure{ self.heureRdv = heureTmp.capitalized }
                else{ self.heureRdv = "-"}
            }
            else{
                self.dateRdv = nil
                self.heureRdv = ""
            }
        }
    }
    
    fileprivate var jourEvaluation : JourEvaluation? = nil {
        didSet{
            if let jourEvaluation = self.jourEvaluation{
                if let jourTmp = jourEvaluation.jour{ self.jourEval = jourTmp }
                else{ self.jourEval = ""}
            }
            else{
                self.jourEval = ""
            }
        }
    }
    
    fileprivate var etat : Etat? = nil {
        didSet{
            if let etat = self.etat{
                if let heureTmp = etat.heure{ self.heureEtat = heureTmp }
                else{ self.heureEtat = ""}
                
                if let etatTmp = etat.reponse{ self.etatRep = etatTmp }
                else{ self.etatRep = ""}
            }
            else{
                self.heureEtat = ""
                self.etatRep = ""
            }
        }
    }
    
    fileprivate var evenement : Evenement? = nil {
        didSet{
            if let evenement = self.evenement{
                if let evenementTmp = evenement.evenement{ self.evenementRep = evenementTmp }
                else{ self.evenementRep = ""}
                
            }
            else{
                self.evenementRep = ""
            }
        }
    }
    
    func configureEvaluation(theCell : EvaluationTableViewCell?, forEvaluation: Evaluation?){
        self.evaluation = forEvaluation
        guard let cell = theCell else { return }
        cell.dateLabel.text = evaluation?.concerneRdv?.convertDate(dateModify: self.dateRdv!)
        cell.heureLabel.text = evaluation?.concerneRdv?.heure
    }
    
    func configureJourEvaluation(theCell : JourEvaluationTableViewCell?, forJourEvaluation: JourEvaluation?){
        self.jourEvaluation = forJourEvaluation
        guard let cell = theCell else { return }
        cell.joursPrecedent.text = self.jourEval
    }
    
    func configureEtat(theCell : EtatTableViewCell?, forEtat: Etat?){
        self.etat = forEtat
        guard let cell = theCell else { return }
        cell.heureLabel.text = self.heureEtat
        cell.etatLabel.text = self.etatRep
        if self.etatRep == "On"{
            cell.etatLabel.backgroundColor = UIColor.green
        }
        else if self.etatRep == "Off"{
            cell.etatLabel.backgroundColor = UIColor.red
        }
        else{
            cell.etatLabel.backgroundColor = UIColor.yellow
        }
    }
    
    func configureEvenement(theCell : EtatTableViewCell?, forEvenement: Evenement?){
        self.evenement = forEvenement
        guard let cell = theCell else { return }
        cell.evenementLabel.text = self.evenementRep
    }
}
