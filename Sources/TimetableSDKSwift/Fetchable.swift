//
//  Fetchable.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation

public protocol Fetchable {
    mutating func fetch(recursively: Bool) throws
}
