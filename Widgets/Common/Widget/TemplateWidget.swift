//
//  TemplateWidget.swift
//  Widgets
//
//  Created by Apple on 15/10/20.
//

import UIKit

class TemplateWidget {
    var id: String = ""
    var name: String?
    var type: String = ""
    var headingFont: String = ""
    var subHeadingFont: String = ""
    var subHeading2Font: String = ""
    var headingLabelTextColor: String = ""
    var overlayAlpha: CGFloat = 0
    var subHeadingLabelTextColor: String = ""
    var headingLabelTextAlpha: CGFloat = 0
    var subHeadingLabel2TextColor: String = ""
    var subHeadingLabeTextAlpha: CGFloat = 0
    var overlayColor: String = ""
    var subHeadingLabel2TextAlpha: CGFloat = 0
    var borderWidth: Int = 0
    var isPro: Int = 0
    var borderColor: String = ""
    var templateId: String = ""
    var bgImage: String = ""
    var dueDate:Date?
    var headingText: String?
    var subHeadingText: String?
    var subHeading2Text: String?

    var variantsStringData:[[String:Any]] = []
    
    var variants:[TemplateWidgetVariant] = []
    var currentvariant:TemplateWidgetVariant?

    init() {}
    
    init(json:[String:Any]) {
        bgImage = json["bg"] as! String
        templateId = json["templateId"] as! String
        type = json["type"] as! String
        overlayColor = json["overlayColor"] as! String
        overlayAlpha = json["overlayAlpha"] as! CGFloat
        borderColor = json["borderColor"] as! String
        borderWidth = json["borderWidth"] as! Int
        headingFont = json["headingLabelFont"] as! String
        subHeadingFont = json["subHeadingLabelFont"] as! String
        subHeading2Font = json["subHeadingLabel2Font"] as! String
        headingLabelTextColor = json["headingLabelTextColor"] as! String
        headingLabelTextAlpha = json["headingLabelTextAlpha"] as? CGFloat ??  1
        subHeadingLabelTextColor = json["subHeadingLabelTextColor"] as! String
        subHeadingLabeTextAlpha = json["subHeadingLabeTextAlpha"] as? CGFloat ??  1
        subHeadingLabel2TextColor = json["subHeadingLabel2TextColor"] as! String
        subHeadingLabel2TextAlpha = json["subHeadingLabel2TextAlpha"] as? CGFloat ??  1
        isPro = json["isPro"] as? Int ?? 0

        variantsStringData = json["variants"] as? [[String:Any]] ?? []
        
        for variant in variantsStringData{
            variants.append(TemplateWidgetVariant(json: variant))

//            switch type {
//            case WidgetType.calendar.rawValue:
//                variants.append(TemplateWidgetVariant(json: variant))
//            case WidgetType.reminder.rawValue:
//                variants.append(TemplateWidgetVariant(json: variant))
//            case WidgetType.quote.rawValue:
//                variants.append(TemplateWidgetVariant(json: variant))
//            default:
//                print("not found")
//            }
        }
    }
    
    init(widget: WidgetCollection) {
        id = widget.id!
        name = widget.name
        templateId = widget.templateId!
        type = widget.type!
        overlayColor = widget.overlayColor!
        overlayAlpha = CGFloat(widget.overlayAlpha)
        borderWidth = Int(widget.borderWidth)
        borderColor = widget.borderColor!
        templateId = widget.templateId!
        bgImage = widget.background!
        dueDate = widget.dueDate
        headingText = widget.headingText
        subHeadingText = widget.subHeadingText
        subHeading2Text = widget.subHeading2Text
        headingFont = widget.headingLabelFont!
        subHeadingFont = widget.subHeadingLabelFont!
        subHeading2Font = widget.subHeadingLabel2Font!
        headingLabelTextColor = widget.headingLabelTextColor!
        headingLabelTextAlpha = CGFloat(widget.headingLabelTextAlpha)
        subHeadingLabelTextColor = widget.subHeadingLabelTextColor!
        subHeadingLabeTextAlpha = CGFloat(widget.subHeadingLabeTextAlpha)
        subHeadingLabel2TextColor = widget.subHeadingLabel2TextColor!
        subHeadingLabel2TextAlpha = CGFloat(widget.subHeadingLabel2TextAlpha)
        variantsStringData = widget.varients?.array() ?? []
        
        var variants:[TemplateWidgetVariant] = []

        for variant in variantsStringData{
            variants.append(TemplateWidgetVariant(json: variant))
//            switch type {
//            case WidgetType.calendar.rawValue:
//                variants.append(TemplateWidgetVariant(json: variant))
//            case WidgetType.reminder.rawValue:
//                variants.append(TemplateWidgetVariant(json: variant))
//            case WidgetType.quote.rawValue:
//                variants.append(TemplateWidgetVariant(json: variant))
//            default:
//                print("not found")
//            }
        }
        self.variants = variants
    }
    
    func toWidgetCollection() -> WidgetCollection{
        let widgetCollection = WidgetCollection(context: CoreDataStorage.mainQueueContext())
        widgetCollection.id = NSUUID().uuidString
        widgetCollection.name = name
        widgetCollection.templateId = templateId
        widgetCollection.type = type
        widgetCollection.overlayColor = overlayColor
        widgetCollection.overlayAlpha = Double(overlayAlpha)
        widgetCollection.borderWidth = Double(borderWidth)
        widgetCollection.borderColor = borderColor
        widgetCollection.templateId = templateId
        widgetCollection.background = bgImage
        widgetCollection.dueDate = dueDate
        widgetCollection.headingText = headingText
        widgetCollection.subHeadingText = subHeadingText
        widgetCollection.subHeading2Text = subHeading2Text
        widgetCollection.headingLabelTextColor = headingLabelTextColor
        widgetCollection.headingLabelTextAlpha = Double(headingLabelTextAlpha)
        widgetCollection.subHeadingLabelTextColor = subHeadingLabelTextColor
        widgetCollection.subHeadingLabeTextAlpha = Double(subHeadingLabeTextAlpha)
        widgetCollection.subHeadingLabel2TextColor = subHeadingLabel2TextColor
        widgetCollection.subHeadingLabel2TextAlpha = Double(subHeadingLabel2TextAlpha)
        widgetCollection.headingLabelFont = headingFont
        widgetCollection.subHeadingLabelFont = subHeadingFont
        widgetCollection.subHeadingLabel2Font = subHeading2Font
        widgetCollection.varients = variantsStringData.json()
        return widgetCollection
    }
    
    func fill(in obj:WidgetCollection) -> WidgetCollection{
        obj.id = NSUUID().uuidString
        obj.name = name
        obj.templateId = templateId
        obj.type = type
        obj.overlayColor = overlayColor
        obj.overlayAlpha = Double(overlayAlpha)
        obj.borderWidth = Double(borderWidth)
        obj.borderColor = borderColor
        obj.templateId = templateId
        obj.background = bgImage
        obj.dueDate = dueDate
        obj.headingText = headingText
        obj.subHeadingText = subHeadingText
        obj.subHeading2Text = subHeading2Text
        obj.headingLabelTextColor = headingLabelTextColor
        obj.headingLabelTextAlpha = Double(headingLabelTextAlpha)
        obj.subHeadingLabelTextColor = subHeadingLabelTextColor
        obj.subHeadingLabeTextAlpha = Double(subHeadingLabeTextAlpha)
        obj.subHeadingLabel2TextColor = subHeadingLabel2TextColor
        obj.subHeadingLabel2TextAlpha = Double(subHeadingLabel2TextAlpha)
        obj.headingLabelFont = headingFont
        obj.subHeadingLabelFont = subHeadingFont
        obj.subHeadingLabel2Font = subHeading2Font
        obj.varients = variantsStringData.json()
        return obj
    }
}

class TemplateWidgetVariant {
    var size:String = "small"
    var headingLabelFontSize: CGFloat! = 0
    var subHeadingLabelFontSize: CGFloat! = 0
    var subHeadingLabel2FontSize: CGFloat! = 0
    var headingLabelTopPadding: CGFloat! = 0
    var headingLabelLeftPadding: CGFloat! = 0
    var subHeadingLabelTopPadding: CGFloat! = 0
    var subHeadingLabelLeftPadding: CGFloat! = 0
    var subHeadingLabel2TopPadding: CGFloat! = 0
    var subHeadingLabel2LeftPadding: CGFloat! = 0
    
    var timeFormat: String? = "hh:mm"
    var dateFormat: String? = "dd MMM yyyy"

    init(json:[String:Any]) {
        size = json["size"] as! String
        headingLabelFontSize = json["headingLabelFontSize"] as? CGFloat ?? 0
        subHeadingLabelFontSize = json["subHeadingLabelFontSize"] as? CGFloat ?? 0
        subHeadingLabel2FontSize = json["subHeadingLabel2FontSize"] as? CGFloat ?? 0
        headingLabelTopPadding = json["headingLabelTopPadding"] as? CGFloat ?? 0
        headingLabelLeftPadding = json["headingLabelLeftPadding"] as? CGFloat ?? 0
        subHeadingLabelTopPadding = json["subHeadingLabelTopPadding"] as? CGFloat ?? 0
        subHeadingLabelLeftPadding = json["subHeadingLabelLeftPadding"] as? CGFloat ?? 0
        subHeadingLabel2TopPadding = json["subHeadingLabel2TopPadding"] as? CGFloat ?? 0
        subHeadingLabel2LeftPadding = json["subHeadingLabel2LeftPadding"] as? CGFloat ?? 0
        timeFormat = json["timeFormat"] as? String
        dateFormat = json["dateFormat"] as? String
    }
    
    init() {}
}

//class CalendarTemplateWidget:TemplateWidget {
//    var dateFont: String = ""
//    var monthFont: String = ""
//    var dayLabelTextColor: String = ""
//    var monthLabelTextColor: String = ""
//
//    override init(json:[String:Any]) {
//        super.init(json: json)
//        dateFont = json["headingLabelFont"] as! String
//        monthFont = json["subHeadingLabelFont"] as! String
//        dayLabelTextColor = json["headingLabelTextColor"] as! String
//        monthLabelTextColor = json["headingLabelTextColor"] as! String
//    }
//
//    override init(widget: WidgetCollection) {
//        super.init(widget: widget)
//        dateFont = widget.font!
//        monthFont = widget.font!
//        dayLabelTextColor = widget.textColor!
//        monthLabelTextColor = widget.textColor!
//    }
//}

//class CalendarTemplateWidgetVariant:TemplateWidgetVariant {
//    var dateLabelFontSize: Int = 0
//    var monthLabelFontSize: Int = 0
//
//    override init(json:[String:Any]) {
//        super.init(json: json)
//        dateLabelFontSize = json["headingLabelFontSize"] as! Int
//        monthLabelFontSize = json["subHeadingLabelFontSize"] as! Int
//    }
//}

//class ReminderTemplateWidget:TemplateWidget {
//    var headingFont: String = ""
//    var subHeadingFont: String = ""
//    var headingLabelTextColor: String = ""
//    var subHeadingLabelTextColor: String = ""
//
//    override init(json:[String:Any]) {
//        super.init(json: json)
//        headingFont = json["headingLabelFont"] as! String
//        subHeadingFont = json["subHeadingLabelFont"] as! String
//        headingLabelTextColor = json["headingLabelTextColor"] as! String
//        subHeadingLabelTextColor = json["subHeadingLabelTextColor"] as! String
//    }
//
//    override init(widget: WidgetCollection) {
//        super.init(widget: widget)
//        headingFont = widget.font!
//        subHeadingFont = widget.font!
//        headingLabelTextColor = widget.textColor!
//        subHeadingLabelTextColor = widget.textColor!
//    }
//}

//class ReminderTemplateWidgetVariant:TemplateWidgetVariant {
//    var headingLabelFontSize: Int = 0
//    var subHeadingLabelFontSize: Int = 0
//
//    override init(json:[String:Any]) {
//        super.init(json: json)
//        headingLabelFontSize = json["headingLabelFontSize"] as! Int
//        subHeadingLabelFontSize = json["subHeadingLabelFontSize"] as! Int
//    }
//}

