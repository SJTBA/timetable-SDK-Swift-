//
//  AdmissionYear.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation
import Scrape

public struct AdmissionYear: _HTMLRepresentable, TimetableEntity {
    
    public var name: String
    public var url: URL
    public var groups: [AcadimicGroup]?
    public var timetable: Timetable
    
    internal var _html: String?
    internal var _page: HTMLDocument?
    
    internal init(name: String,
                  url: URL,
                  timetable: Timetable,
                  fetch: Bool,
                  recursively: Bool = false) throws {
        
        self.name = name
        self.url = url
        self.timetable = timetable
        
        if fetch {
            try self.fetch(recursively: recursively)
        }
    }
}

extension AdmissionYear: Fetchable {
    
    public mutating func fetch(recursively: Bool = false) throws {
        
        try getHTML(for: url)
        try parseHTML()
        
        func createGroup(from element: Scrape.XMLElement) throws -> AcadimicGroup {
            
            let name = element
                .element(atXPath: .groupName)?
                .text?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? "null"
            
            let timetableURL = timetable.url
            let _url = timetableURL.isFileURL ? timetableURL.deletingLastPathComponent() : timetableURL
            let groupURL = _url.appendingPathComponent(
                element
                .element(atXPath: .groupURL)?["onclick"]?
                .replacingOccurrences(of: "^[^']*|'", with: "", options: .regularExpression) ?? ""
            )
            
            return try AcadimicGroup(name: name,
                                     url: groupURL,
                                     timetable: timetable,
                                     fetch: recursively,
                                     recursively: recursively)
        }
        
        groups = try _page?.search(byXPath: .groupRows).map(createGroup)
    }
}
