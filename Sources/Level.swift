//
//  Level.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation
import Scrape

public struct Level {
    
    public var name: String
    public var specializations: [Specialization]?
    internal var _element: Scrape.XMLElement
    
    internal init(name: String,
                  element: Scrape.XMLElement,
                  fetch: Bool = false,
                  recursively: Bool = false) {
        
        self.name = name
        _element = element
        
        if fetch {
            try? self.fetch(recursively: recursively)
        }
    }
}

extension Level: Fetchable {
    
    public mutating func fetch(recursively: Bool = false) throws {
        
        func createSpecialization(from element: Scrape.XMLElement) -> Specialization {
            
            let name = element
                .element(atXPath: .specializationName)?
                .text?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? "null"
            
            return Specialization(name: name,
                                  element: element,
                                  fetch: recursively,
                                  recursively: recursively)
        }
        
        specializations = _element
            .search(byXPath: .specializationRows)
            .dropFirst()
            .map(createSpecialization)
    }
}
