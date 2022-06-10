//
//  MainPageViewController.swift
//  Books
//
//  Created by Alexandra Zambitchi on 01.06.2022.
//

import UIKit
import UserNotifications

class MainPageViewController: UIViewController {
    
    
    @IBOutlet weak var buttonAnim1: UIButton!
    
    
    @IBOutlet weak var buttonAnim2: UIButton!

    
    @IBOutlet weak var anim1: UILabel!
    
    
    @IBOutlet weak var anim2: UILabel!
    
    //    let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Book Nerds"
        content.body = "Read something new today? Come back to app!"
        
        let date = Date().addingTimeInterval(20)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//        var dateComponents = DateComponents()
//        dateComponents.hour = 16
//        dateComponents.minute = 10
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request){ (error) in
            
        }
    }
    
    
    @IBAction func animation1(_ sender: UIButton) {
        UIView.animate(withDuration: 5, animations: {
            self.anim1.center = self.view.center
            self.anim1.frame.origin.y += 30
        })
    }
    
    @IBAction func animation2(_ sender: UIButton) {
        UIView.animateKeyframes(withDuration: 10, delay: 0, options: [.calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.anim2.center = self.view.center
                self.anim2.frame.origin.y += 80
            })
            
        }, completion: {finished in  print("Animation complete")})
    }
    
    
}
