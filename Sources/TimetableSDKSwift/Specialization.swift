//
//  Specialization.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation
import Scrape

public struct Specialization: TimetableEntity {
    
    public var name: String
    public var years: [AdmissionYear]?
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

extension Specialization: Fetchable {
    
    public mutating func fetch(recursively: Bool = false) throws {
        
        func createAdmissionYear(from element: Scrape.XMLElement) throws -> AdmissionYear {
            
            let year = element.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "0"
            let timetableURL = timetable.url
            let _url = timetableURL.isFileURL ? timetableURL.deletingLastPathComponent() : timetableURL
            let yearURL = _url.appendingPathComponent(element["href"] ?? "")
            
            return try AdmissionYear(name: year,
                                     url: yearURL,
                                     timetable: timetable,
                                     fetch: recursively,
                                     recursively: recursively)
        }
        
        years =  try _element.search(byXPath: .admissionYear).map(createAdmissionYear)
    }
}
