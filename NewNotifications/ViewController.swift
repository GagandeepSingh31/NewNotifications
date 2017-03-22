//
//  ViewController.swift
//  NewNotifications
//
//  Created by Gagandeep Singh on 3/22/17.
//  Copyright © 2017 Gagandeep Singh. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Request notification permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound] , completionHandler: { (granted, error) in
            
            if granted {
                print("Notification access granted")
            }else {
                print(error?.localizedDescription)
            }
            
        })
    }

    
    @IBAction func notifyButtonTapped(_ sender: UIButton) {
        
        scheduleNotification(inSeconds: 5, completion: {success in
        
            if success {
                print("Succesfully scheduled notification")
            }else {
                print("Error scheduling notification")
            }
        })
        
    }
    
    //Function to sechedule notification
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (Bool) -> ()) {
        
        let notif = UNMutableNotificationContent()
        
        notif.title = "New Notification"
        notif.subtitle = "These are great"
        notif.body = "The new notification in the IOS 10  are what I've always dreamed of!"
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
            if error != nil {
                print(error)
                completion(false)
            }else {
                completion(true)
            }
        })
    }

}

