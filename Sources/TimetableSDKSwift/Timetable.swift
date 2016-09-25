//
//  Timetable.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 24.09.16.
//
//

import Foundation
import Scrape

open class Timetable {
    
    fileprivate let _url: URL
    internal var _html: String?
    internal var _page: HTMLDocument?
    
    open fileprivate(set) var schools: [School]?
    
    public init(url: URL = URL(string: "http://timetable.spbu.ru")!,
                fetch: Bool = false,
                recursively: Bool = false) throws {

        _url = url

        if fetch {
            try self.fetch(recursively: recursively)
        }
    }
}

extension Timetable: _HTMLRepresentable {
    
    // Workaround for https://bugs.swift.org/browse/SR-142
    internal func getHTML(for url: URL) throws {
        var _self: _HTMLRepresentable = self
        try _self.getHTML(for: url)
    }
    
    // Workaround for https://bugs.swift.org/browse/SR-142
    internal func parseHTML() throws {
        var _self: _HTMLRepresentable = self
        try _self.parseHTML()
    }
}

extension Timetable: Fetchable {
    
    open func fetch(recursively: Bool = false) throws {
        
        try getHTML(for: _url)
        try parseHTML()
        
        func createSchool(from element: Scrape.XMLElement) throws -> School {
            
            let name = element.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "null"
            
            let url = (_url.isFileURL ? _url.deletingLastPathComponent() : _url)
                .appendingPathComponent(element["href"] ?? "")
            
            return try School(name: name, url: url, fetch: recursively, recursively: recursively)
        }
        
        schools = try _page?.search(byXPath: .schoolRows).map(createSchool)
    }
}
