//
//  NotificationsDataManager.swift
//  Template_Onboarding
//
//  Created by Pedro Muñoz Cabrera on 08/03/2021.
//

import UIKit
import UserNotifications

public class NotificationsDataManager : NSObject {
    
    static let shared = NotificationsDataManager()

    var notificationSent: Bool {
        get { UserDefaults.standard.bool(forKey: Constants.notificationKey) }
        set { UserDefaults.standard.setValue(newValue, forKey: Constants.notificationKey) }
    }
    
    public override init() { }

    func sendOnboardingNotification(_ title: String, subtitle: String) {
        sendLocalNotification(with: title, subtitle: subtitle)
    }

    func sendNotification(_ title: String, subtitle: String, dayDelay:Int?) {
        guard !notificationSent else { return }

        var userInfo = [AnyHashable:Any]()
        if dayDelay != nil {
            userInfo["day"] = dayDelay!
        }
        sendLocalNotification(with: title, subtitle: subtitle, userInfo: userInfo)
    }
    
    func removeNotificationSentFlag() {
        notificationSent = false
    }
}

private extension NotificationsDataManager {
    struct Constants {
        static let notificationKey = "notificationKey"
    }

    private func sendLocalNotification(with title: String, subtitle: String, userInfo:[AnyHashable : Any]? = nil) {

        var date : Date?
        
        if let day = userInfo?["day"] as? Int {
        #if DEBUG
            date = Date(timeIntervalSinceNow: Double(day) * 60.0)
        #else
            date = Date(timeIntervalSinceNow: Double(day) * 24.0 * 60.0 * 60.0)
        #endif
        }
        
        if date == nil {
            return
        }
        let triggerDate = Calendar.current.dateComponents([.weekday, .hour, .minute, .second, .year], from: date!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = subtitle
        content.sound = UNNotificationSound.default
        
        if userInfo != nil {
            content.userInfo = userInfo!
        }
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("something went wrong")
            }
        }
    }
}


extension NotificationsDataManager : UNUserNotificationCenterDelegate {
    
    private func manageNotificationWithContent(_ content:UNNotificationContent) {
        /*if let day = content.userInfo["day"] as? Int {
            switch day {
            case 2:
                SessionCacheDataManager.shared.setCurrentOffer(SUBConstants.subscriptionPromo)
            case 3:
                SessionCacheDataManager.shared.setCurrentOffer(SUBConstants.subscriptionYearlyPromo)
            case 7:
                SessionCacheDataManager.shared.setCurrentOffer(SUBConstants.unlockall)
            default:
                SessionCacheDataManager.shared.setCurrentOffer(SUBConstants.subscriptionPromo)
                break
            }
        }
        
        let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
        if let rootvc = sceneDelegate.window?.rootViewController {
            var controller = rootvc
            if let svc = rootvc as? UISplitViewController {
                controller = svc.viewControllers.last ?? rootvc
            } else if rootvc.presentedViewController != nil {
                controller = rootvc.presentedViewController!
            }
            let coordinator = OnboardingCoordinator(controller: controller)
            coordinator.showSpecialGift()
        }*/
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let content = notification.request.content
        manageNotificationWithContent(content)
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
   
        let content = response.notification.request.content
        manageNotificationWithContent(content)

    }
}
