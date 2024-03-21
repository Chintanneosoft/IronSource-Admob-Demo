//
//  IntentHandler.swift
//  IntentsExtension
//
//  Created by Apple on 15/10/20.
//

import Intents
import CoreData

class IntentHandler: INExtension,MultiWidgetTypeIntentHandling {
    func provideWidgetTypeOptionsCollection(for intent: MultiWidgetTypeIntent, with completion: @escaping (INObjectCollection<Widgets>?, Error?) -> Void) {
        
        var widgets: [WidgetCollection] = []
        let context = CoreDataStorage.mainQueueContext()
        let request: NSFetchRequest<WidgetCollection> = WidgetCollection.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            widgets = try context.fetch(request)
            
            let widgetsList: [Widgets] = widgets.map { wid in
                      let widget = Widgets(
                          identifier: wid.name,
                        display: wid.name!
                      )
                widget.widgetId = wid.id
        

                return widget
            }
            
            // Create a collection with the array of characters.
            let collection = INObjectCollection(items: widgetsList)

            // Call the completion handler, passing the collection.
            completion(collection, nil)
        } catch {
            print("Failed")
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
