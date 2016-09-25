//
//  Specialization.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation

public struct Specialization {
    
    public var name: String
    public var years: [AdmissionYear]?
    
    internal init(name: String, fetch: Bool = false, recursively: Bool = false) {
        self.name = name
        
        if fetch {
            try? self.fetch(recursively: recursively)
        }
    }
}

extension Specialization: Fetchable {
    
    public func fetch(recursively: Bool = false) throws {
        
    }
}
