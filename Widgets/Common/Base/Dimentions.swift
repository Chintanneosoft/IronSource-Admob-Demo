//
//  Dimentions.swift
//  Widgets
//
//  Created by Apple on 19/10/20.
//

import Foundation
import UIKit

class Dimentions {
    static func getWidgetSizeFor(_ type: String) -> CGSize{
        if UIScreen.main.bounds.size.width == 414 &&  UIScreen.main.bounds.size.height == 896{
            if type == "small"{
                return CGSize(width: 169, height: 169)
            }
            else if type == "medium"{
                return CGSize(width: 360, height: 169)
            }
            else if type == "large"{
                return CGSize(width: 360, height: 376)
            }
        }
        else if UIScreen.main.bounds.size.width == 375 &&  UIScreen.main.bounds.size.height == 812{
            if type == "small"{
                return CGSize(width: 155, height: 155)
            }
            else if type == "medium"{
                return CGSize(width: 329, height: 155)
            }
            else if type == "large"{
                return CGSize(width: 329, height: 345)
            }
        }
        else if UIScreen.main.bounds.size.width == 414 &&  UIScreen.main.bounds.size.height == 736{
            if type == "small"{
                return CGSize(width: 159, height: 159)
            }
            else if type == "medium"{
                return CGSize(width: 348, height: 159)
            }
            else if type == "large"{
                return CGSize(width: 348, height: 357)
            }
        }
        else if UIScreen.main.bounds.size.width == 375 &&  UIScreen.main.bounds.size.height == 667{
            if type == "small"{
                return CGSize(width: 148, height: 148)
            }
            else if type == "medium"{
                return CGSize(width: 322, height: 148)
            }
            else if type == "large"{
                return CGSize(width: 322, height: 324)
            }
        }
        
        else if UIScreen.main.bounds.size.width == 320 &&  UIScreen.main.bounds.size.height == 558{
            if type == "small"{
                return CGSize(width: 141, height: 141)
            }
            else if type == "medium"{
                return CGSize(width: 291, height: 141)
            }
            else if type == "large"{
                return CGSize(width: 291, height: 299)
            }
        }
        
        if type == "small"{
            return CGSize(width: 169, height: 169)
        }
        else if type == "medium"{
            return CGSize(width: 360, height: 169)
        }
        else{
            return CGSize(width: 360, height: 376)
        }
    }
}
