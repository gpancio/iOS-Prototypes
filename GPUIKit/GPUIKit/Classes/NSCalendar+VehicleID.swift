//
//  NSCalendar+VehicleID.swift
//  Pods
//
//  Created by Graham Pancio on 2016-04-27.
//
//

import Foundation

public extension NSCalendar {
    public static func getCurrentYear() -> NSInteger {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = gregorian?.components(.Year, fromDate: NSDate())
        return components!.year
    }
}