//
//  TimetableEntity.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 26.09.16.
//
//

public protocol TimetableEntity {
    var name: String { get }
    var timetable: Timetable { get }
}
