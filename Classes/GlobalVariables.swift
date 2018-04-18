//
//  GlobalVariables.swift
//  Kibots
//
//  Created by Siya Li on 3/14/18.
//  Copyright © 2018 kibots. All rights reserved.
//

import Foundation
import SwiftyBluetooth
class GlobalVariables {
    
    // These are the properties you can store in your singleton
    public var peripheral: Peripheral? = nil
    
    public var startTimeStamp: Date = Date()
    
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}
