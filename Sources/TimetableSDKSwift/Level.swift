//
//  Level.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation
import Scrape

public struct Level: TimetableEntity {
    
    public var name: String
    public var specializations: [Specialization]?
    public var timetable: Timetable
    
    internal var _element: Scrape.XMLElement
    
    internal init(name: String,
                  element: Scrape.XMLElement,
                  timetable: Timetable,
                  fetch: Bool = false,
                  recursively: Bool = false) throws {
        
        self.name = name
        _element = element
        self.timetable = timetable
        
        if fetch {
            try self.fetch(recursively: recursively)
        }
    }
}

extension Level: Fetchable {
    
    public mutating func fetch(recursively: Bool = false) throws {
        
        func createSpecialization(from element: Scrape.XMLElement) throws -> Specialization {
            
            let name = element
                .element(atXPath: .specializationName)?
                .text?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? "null"
            
            return try Specialization(name: name,
                                      element: element,
                                      timetable: timetable,
                                      fetch: recursively,
                                      recursively: recursively)
        }
        
        specializations = try _element
            .search(byXPath: .specializationRows)
            .dropFirst()
            .map(createSpecialization)
    }
}
