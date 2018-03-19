//
//  File.swift
//  My_Pk_Et_Moi
//
//  Created by Bazaz on 19/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation

extension Rdv{
    func convertDate(dateModify : NSDate) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: dateModify as Date)
    }
}
