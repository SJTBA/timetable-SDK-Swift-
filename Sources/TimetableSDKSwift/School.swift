//
//  School.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation
import Scrape

public struct School: _HTMLRepresentable, TimetableEntity {
    
    public var name: String
    public var url: URL
    public var levels: [Level]?
    public var timetable: Timetable
    
    internal var _html: String?
    internal var _page: HTMLDocument?
    
    internal init(name: String,
                  url: URL,
                  timetable: Timetable,
                  fetch: Bool = false,
                  recursively: Bool = false) throws {
        
        self.name = name
        self.url = url
        self.timetable = timetable
        
        if fetch {
            try self.fetch(recursively: recursively)
        }
    }
}

extension School: Fetchable {
    
    public mutating func fetch(recursively: Bool = false) throws {
        
        try getHTML(for: url)
        try parseHTML()
        
        func createLevel(from element: Scrape.XMLElement) throws -> Level {
            
            let name = element
                .element(atXPath: .levelName)?
                .text?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? "null"
            
            return try Level(name: name,
                             element: element,
                             timetable: timetable,
                             fetch: recursively,
                             recursively: recursively)
        }
        
        levels = try _page?.search(byXPath: .levelGroups).map(createLevel)
    }
}
