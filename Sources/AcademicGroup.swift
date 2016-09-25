//
//  AcademicGroup.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation

public struct AcadimicGroup {
    
    public var name: String
    public var url: URL
    
    internal init(name: String, url: URL, fetch: Bool = false, recursively: Bool = false) {
        
        self.name = name
        self.url = url
        
        if fetch {
            try? self.fetch(recursively: recursively)
        }
    }
}

extension AcadimicGroup: Fetchable {
    
    public func fetch(recursively: Bool = false) throws {
        
    }
}
