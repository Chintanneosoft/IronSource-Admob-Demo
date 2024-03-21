//
//  CalanderView.swift
//  Widgets
//
//  Created by Apple on 18/10/20.
//

import Foundation
import SwiftUI
import WidgetKit


struct BackgroundView: View {
    var entry: TemplateWidget
    var body: some View {
        GeometryReader  { g in
            Image(uiImage: UIImage(contentsOfFile: entry.bgImage) ??  UIImage(named: entry.bgImage) ?? UIImage.from(color: .white)).resizable().aspectRatio(contentMode: .fill)
                .frame(width:g.size.width, height: g.size.height)
                .overlay(Color(hex: entry.overlayColor).opacity(Double(entry.overlayAlpha)))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke((Color(hex:entry.borderColor)), lineWidth: CGFloat(entry.borderWidth))
                )
        }
    }
}

struct CalanderView: View {
    var entry: TemplateWidget
    var variant: TemplateWidgetVariant

    var body: some View {
        GeometryReader  { g in
                ZStack(alignment: .leading){
                    Text(Date().toString(format: variant.timeFormat ?? "hh:mm"))
                        .frame(maxWidth:.infinity, maxHeight: .infinity , alignment: .topTrailing)
                        .padding(.top, variant.headingLabelTopPadding)
                        .padding(.trailing, 10)
                        .font(.custom(entry.headingFont, size: variant.headingLabelFontSize ?? 50))
                        .minimumScaleFactor(0.01)
                        .foregroundColor(Color(hex:entry.headingLabelTextColor).opacity(Double(entry.headingLabelTextAlpha)))
                        .lineLimit(nil)
                        .multilineTextAlignment(.trailing)
                    Text(Date().toString(format: variant.dateFormat ?? "EEEE dd MMMM"))
                        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topLeading)
                        .font(.custom(entry.subHeadingFont, size: variant.subHeadingLabelFontSize ?? 20))
                        .minimumScaleFactor(0.01)
                        .foregroundColor(Color(hex:entry.subHeadingLabelTextColor)).opacity(Double(entry.subHeadingLabeTextAlpha))
                        .padding(.top, variant.subHeadingLabelTopPadding)
                        .padding(.leading, variant.subHeadingLabelLeftPadding)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(BackgroundView(entry: entry))
    }
}

struct WidgetViews_Previews: PreviewProvider {
    static var previews: some View {
        CalanderView(entry: TemplateWidget(), variant: TemplateWidgetVariant())
    }
}

