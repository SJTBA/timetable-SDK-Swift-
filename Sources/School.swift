//
//  School.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation
import Scrape

public struct School: _HTMLRepresentable {
    
    public var name: String
    public var url: URL
    public var levels: [Level]?
    internal var _html: String?
    internal var _page: HTMLDocument?
    
    internal init(name: String, url: URL, fetch: Bool = false, recursively: Bool = false) {
        self.name = name
        self.url = url
        
        if fetch {
            try? self.fetch(recursively: recursively)
        }
    }
}

extension School: Fetchable {
    
    public mutating func fetch(recursively: Bool = false) throws {
        
        try getHTML(for: url)
        try parseHTML()
        
        func createLevel(from element: Scrape.XMLElement) -> Level {
            
            let name = element.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "null"
            
            return Level(name: name, fetch: recursively, recursively: recursively)
        }
        
        levels = _page?.search(byXPath: .levelRows).map(createLevel)
    }
}
