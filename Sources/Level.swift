//
//  Level.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation

public struct Level {
    
    public var name: String
    public var specializations: [Specialization]?
    
    internal init(name: String, fetch: Bool = false, recursively: Bool = false) {
        self.name = name
        
        if fetch {
            try? self.fetch()
        }
    }
}

extension Level: Fetchable {
    
    public func fetch(recursively: Bool = false) throws {
        
    }
}
