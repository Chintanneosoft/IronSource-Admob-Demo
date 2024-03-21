//
//  AppDelegate.swift
//  Widgets
//
//  Created by Apple on 15/10/20.
//

import UIKit
import CoreData
import AppTrackingTransparency
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().delegate = NotificationsDataManager.shared
        
        let isDefaultWidgetAdded = UserDefaults.standard.bool(forKey: "defaultWidget")
        if isDefaultWidgetAdded != true{
            saveDefaultWidget()
            UserDefaults.standard.setValue(true, forKey: "defaultWidget")
            UserDefaults.standard.synchronize()
        }

        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "first_launch") == nil {
            defaults.set("X", forKey: "first_launch")
            defaults.synchronize()
        } else {

        }
//        MARK: - Configure Firebase
        FirebaseApp.configure()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    func saveDefaultWidget() {
        func save(){
            do {
                try CoreDataStorage.mainQueueContext().save()
            } catch {
                print("Failed saving")
            }
        }
        
        let firstWidget =  allWidgets().first
        
        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupId)
        let imagePath = (documentsDirectory?.appendingPathComponent("\(firstWidget?.id ?? "widget")-bgImage.png"))!
        let image = UIImage(named: firstWidget!.bgImage)
        try! image?.pngData()?.write(to: imagePath)
        firstWidget?.bgImage = imagePath.path
        firstWidget?.name = "Widget#1"

        var newWidget = WidgetCollection(context: CoreDataStorage.mainQueueContext())
        newWidget = (firstWidget?.fill(in: newWidget))!

        
        
        save()
    }
    
    func allWidgets() ->[TemplateWidget] {
        var allWidgets:[TemplateWidget] = []
        if let path = Bundle.main.path(forResource: "templates", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let templatesList = jsonResult as? [[String:Any]]{
                    for template in templatesList{
                        let templateObj = TemplateWidget(json: template)
                        allWidgets.append(templateObj)
                    }
                }
            } catch {
                // handle error
            }
        }
        return allWidgets
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    

}

extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}
