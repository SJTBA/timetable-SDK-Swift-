//
//  Specialization.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation
import Scrape

public struct Specialization {
    
    public var name: String
    public var years: [AdmissionYear]?
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

extension Specialization: Fetchable {
    
    public func fetch(recursively: Bool = false) throws {
        Unimplemented()
    }
}
