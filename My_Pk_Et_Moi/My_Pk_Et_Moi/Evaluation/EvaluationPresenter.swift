//
//  EvaluationPresenter.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 18/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation

class EvaluationPresenter: NSObject {
    fileprivate var dateRdv : NSDate?
    fileprivate var heureRdv : String = ""
    
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
    
    func configure(theCell : EvaluationTableViewCell?, forEvaluation: Evaluation?){
        self.evaluation = forEvaluation
        guard let cell = theCell else { return }
        //cell.dateLabel.text = self.dateRdv
        cell.heureLabel.text = self.heureRdv
    }
}
