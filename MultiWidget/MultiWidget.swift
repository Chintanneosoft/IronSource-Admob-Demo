//
//  MultiWidget.swift
//  MultiWidget
//
//  Created by Apple on 15/10/20.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> WidgetEntery {
        let widget = TemplateWidget()
        widget.id = "1"
        widget.headingText = "Loading"
        widget.subHeadingText = "Loading"
        return WidgetEntery(date: Date(), detail: widget)
    }

    func getSnapshot(for configuration: MultiWidgetTypeIntent, in context: Context, completion: @escaping (WidgetEntery) -> ()) {
        let widget = TemplateWidget()
        widget.id = "1"
        widget.headingText = "Loading"
        let entry = WidgetEntery(date: Date(), detail: widget)
        completion(entry)
    }

    func getTimeline(for configuration: MultiWidgetTypeIntent, in context: Context, completion: @escaping (Timeline<WidgetEntery>) -> ()) {
        
        var entries: [WidgetEntery] = []
        
        let context = CoreDataStorage.mainQueueContext()
        let request: NSFetchRequest<WidgetCollection> = WidgetCollection.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            if let widgetId = configuration.widgetType?.widgetId{
                request.predicate = NSPredicate(format: "id == %@", widgetId)
            }
            
            if let widget = (try context.fetch(request).first){
                let templateWidget = TemplateWidget(widget: widget)
                
                let entry = WidgetEntery(date: Date().addMin(numberOfMin: 1), detail: templateWidget)
                entries.append(entry)
                
                let entry1 = WidgetEntery(date: Date().addMin(numberOfMin: 2), detail: templateWidget)
                entries.append(entry1)
            }
            
        } catch {
            print("Failed")
        }
        print(Date().addMin(numberOfMin: 1).toString(format: "dd:MMM:yyyy hh:mm:ss"))
        let timeline = Timeline(entries: entries, policy: .after(Date().addMin(numberOfMin: 1)))
        completion(timeline)
    }
}

struct WidgetEntery: TimelineEntry {
    let date: Date
    let detail: TemplateWidget
}

struct MultiWidgetEntryView : View {
    @Environment(\.widgetFamily)
    var family: WidgetFamily

    var entry: Provider.Entry
    
    var body: some View {
        
        switch family { 
            case .systemSmall:
                CalanderView(entry: entry.detail, variant: entry.detail.variants.filter({$0.size == "small"}).first!)
            case .systemMedium:
                CalanderView(entry: entry.detail, variant: entry.detail.variants.filter({$0.size == "medium"}).first!)
            case .systemLarge:
                CalanderView(entry: entry.detail, variant: entry.detail.variants.filter({$0.size == "large"}).first!)
            default:
                CalanderView(entry: entry.detail, variant: entry.detail.variants.filter({$0.size == "small"}).first!)
        }
    }
}

@main
struct MultiWidget: Widget {
    let kind: String = "MultiWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: MultiWidgetTypeIntent.self, provider: Provider()) { entry in
            MultiWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MultiWidget_Previews: PreviewProvider {
    static var previews: some View {
        MultiWidgetEntryView(entry: WidgetEntery(date: Date(), detail: TemplateWidget()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
