//
//  NotificationsSchedule.swift
//  My_Pk_Et_Moi
//
//  Created by Elyes DOUDECH on 28/03/2018.
//  Copyright © 2018 Elyes DOUDECH. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationsSchedule
{
    struct Notification
    {
        struct Category
        {
            static let traitement = "traitement"
            static let sport = "sport"
            static let evaluation = "evaluation"
            static let rdv = "rdv"
        }
        
        struct Action
        {
            static let showDetails = "showDetails"
            static let unsubscribe = "unsubscribe"
        }
        
        
    }
    /// This method schedule a new local notification
    ///
    /// - Parameters:
    ///   - hour: the hour of triggger of the notification
    ///   - minute: the minute of triggger of the notification
    ///   - weekDay: the day of the week of triggger of the notification
    ///   - day: the day of the mobth of triggger of the notification
    ///   - month: the month of triggger of the notification
    ///   - image: the image url that will be displayed in the notificaiton
    ///   - ext: the extension of the image
    ///   - title: the title of the notification
    ///   - subtitle: the subtitle of the notification
    ///   - body: the body of the notification
    ///   - category: the category
    ///   - repeated: ture : repaet the notification, false only one
    static func scheduleNotification(hour: Int, minute: Int,weekDay : Int?,day : Int?,month : Int?, image : String, ext : String, title : String, subtitle : String, body : String, category : String, repeated : Bool)
    {
        
        //add atachment
        
        guard let imageUrl = Bundle.main.url(forResource: image, withExtension: ext ) else {
            
            return
        }
        
        let identifier : String = UUID().uuidString
        var attachment: UNNotificationAttachment
        
        
        
        attachment = try! UNNotificationAttachment(identifier: identifier, url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        notif.title = title
        notif.subtitle = subtitle
        notif.body = body
        notif.categoryIdentifier = category
        notif.userInfo = ["Redirection" : "Traitement"]
        
        notif.attachments = [attachment]
        
        var dateInfo = DateComponents()
        dateInfo.hour = hour
        dateInfo.minute = minute
        if weekDay != nil
        {
            dateInfo.weekday = weekDay
        }
        
        if day != nil
        {
           /* var d = day!
            if d == 0
            {
                d = 1
            }
            else if(d < 1)
            {
               
               
                     d = calender.
            }*/
            dateInfo.day = day
            
        }
        
        if month != nil
        {
            if day! < 1
            {
                dateInfo.month = (month! - 1)
            }
            else
            {
                dateInfo.month = month
            }
            
        }
        
        let notifTrigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: repeated)
        
        let request = UNNotificationRequest(identifier: identifier, content: notif, trigger: notifTrigger)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error : Error?) in
            if let theError = error
            {
                print(theError.localizedDescription)
            }
        }
    }
}
