//
//  AdmissionYear.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation

public struct AdmissionYear: TimetableEntity {
    
    public var name: String
    public var url: URL
    public var groups: [AcadimicGroup]?
    public var timetable: Timetable
    
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
    
    public func fetch(recursively: Bool = false) throws {
        Unimplemented()
    }
}
