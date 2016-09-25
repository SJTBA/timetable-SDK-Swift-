//
//  AdmissionYear.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation

public struct AdmissionYear {
    
    public var year: Int
    public var url: URL
    public var groups: [AcadimicGroup]?
    
    internal init(year: Int, url: URL, fetch: Bool, recursively: Bool = false) {
        self.year = year
        self.url = url
        
        if fetch {
            try? self.fetch(recursively: recursively)
        }
    }
}

extension AdmissionYear: Fetchable {
    
    public func fetch(recursively: Bool = false) throws {
        
    }
}
