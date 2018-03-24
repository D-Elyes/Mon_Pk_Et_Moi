//
//  DatePickerInitialiser.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 21/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation
import UIKit

class DatePickerInitiliser
{
    var datePicker : UIDatePicker
    
    init() {
        
        datePicker = UIDatePicker()
    }
    
    
    /// This function is to update the textfield when the user change the date de fin
    ///
    /// - Parameter sender: the corresponding datePicker
    func datePickedValueChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateStyle = DateFormatter.Style.long
        //formatter.timeStyle = DateFormatter.Style.none
        
        
       
    }
    
   
    
}
