//
//  _TimetableXPaths.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Scrape

internal struct _TimetableXPaths: RawRepresentable {
    
    internal var rawValue: String
    
    internal init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    internal static let schoolRows = _TimetableXPaths(rawValue:
        "(//div[@class='panel panel-default'])[1]//li[@class='list-group-item']//a")
    
    internal static let levelGroups = _TimetableXPaths(rawValue:
        "(//div[@class='panel-group'])[1]//div[@class='panel panel-default']")
    
    internal static let levelName = _TimetableXPaths(rawValue: ".//*[@class='panel-title']//a")
    
    internal static let specializationRows = _TimetableXPaths(rawValue:
        ".//*[@class='common-list-item row']")
    
    internal static let specializationName = _TimetableXPaths(rawValue: ".//div[@class='col-sm-6']")
}

internal extension Searchable {
    
    internal final func search(byXPath xpath: _TimetableXPaths) -> XPathResult {
        return search(byXPath: xpath.rawValue)
    }
    
    internal final func element(atXPath xpath: _TimetableXPaths) -> XMLElement? {
        return element(atXPath: xpath.rawValue)
    }
}
