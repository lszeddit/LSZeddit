//
//  Date+Extension.swift
//  LSZeddit
//
//  Created by Carlos Acosta on 4/10/19.
//  Copyright © 2019 LSZTech. All rights reserved.
//

import Foundation

extension Date{
    
    static func getAge(of epochTime: Double) -> String{
        let date = Date(timeIntervalSince1970: epochTime)
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: date, to: Date())
        if ageComponents.year != 0{
            return "\(ageComponents.year!)y"
        } else if ageComponents.month != 0{
            return "\(ageComponents.month!)m"
        } else if ageComponents.day != 0 {
            return "\(ageComponents.day!)d"
        } else if ageComponents.hour != 0 {
            print(ageComponents.hour!)
            return "\(ageComponents.hour!)h"
        } else if ageComponents.minute != 0{
            return "\(ageComponents.minute!)m"
        }else {
            return "Just now"
        }
    }
}
