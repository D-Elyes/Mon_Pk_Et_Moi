//
//  SportPresenter.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 12/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation

class SportPresenter: NSObject {
    fileprivate var nomSport : String = ""
    fileprivate var typeSport : String = ""
    fileprivate var heure : String = ""
    //fileprivate var jour : [String] = []  a compléter
    
    fileprivate var sport : Activite? = nil {
        didSet{
            if let sport = self.sport{
                if let nomTmp = sport.nom{ self.nomSport = nomTmp.capitalized }
                else{ self.nomSport = "-"}
                
                if let typeTmp = sport.type{ self.typeSport = typeTmp.capitalized }
                else{ self.typeSport = "-"}
                
                if let heureTmp = sport.heure{ self.heure = heureTmp.capitalized }
                else{ self.heure = "-"}
                
                /*if let nomTmp = sport.nom{ self.nomSport = nomTmp.capitalized }
                else{ self.nomSport = "-"}*/
            }
            else{
                self.nomSport = ""
                self.typeSport = ""
                self.heure = ""
                //self.jour = []
            }
        }
    }
    
    func configure(theCell : SportTableViewCell?, forSport: Activite?){
        self.sport = forSport
        guard let cell = theCell else { return }
        cell.nomlabel.text = self.nomSport
        cell.typeLabel.text = self.typeSport
        cell.heureLabel.text = self.heure
    }
}
