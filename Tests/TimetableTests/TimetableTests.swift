//
//  TimetableTests.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import XCTest
import Foundation
import TimetableSDKSwift

class TimetableTests: XCTestCase {
    
    var timetable: Timetable!
    
    struct Seeds {
        
        static let schools = [
            "Academic Gymnasium",
            "Arts",
            "Mathematics and Mechanics"
        ]
        
        static let levels = [
            "Bachelor Studies",
            "Master Studies"
        ]
        
        static let specializationsForBachelors = [
            "Mathematics",
            "Software Engineering"
        ]
        
        static let specializationsForMasters = [
            "Applied Mathematics and Informatics",
            "Fundamental Informatics and Information Technology"
        ]
    }
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        let indexURL = getURLForTestingResource(forFile: "index", ofType: "html")!
        
        do {
            timetable = try Timetable(url: indexURL, fetch: true, recursively: false)
        } catch {
            XCTFail(String(describing: error))
            
        }
    }
    
    func testGetSchools() {
        
        // Given
        let expectedSchools = Seeds.schools
        
        // When
        try? timetable.fetch(recursively: false)
        
        // Then
        XCTAssertNotNil(timetable.schools, "The list of schools should be initialized after fetching")
        
        // When
        let returnedSchools = timetable.schools!.map { $0.name }
        
        // Then
        XCTAssertEqual(expectedSchools, returnedSchools)
    }
    
    func testGetLevelsForSchool() {
        
        // Given
        let expectedLevels = Seeds.levels
        
        // When
        try? timetable.fetch(recursively: false)
        var school = timetable.schools![2]
        try? school.fetch(recursively: false)
        
        // Then
        XCTAssertNotNil(school.levels, "The list of levels should be initialized after fetching")
        
        // When
        let returnedLevels = school.levels!.map { $0.name }
        
        // Then
        XCTAssertEqual(expectedLevels, returnedLevels)
    }
    
    func testSpecializationsForLevels() {
        
        // Given
        let expectedSpecializationsForBachelors = Seeds.specializationsForBachelors
        let expectedSpecializationsForMasters = Seeds.specializationsForMasters
        
        // When
        try? timetable.fetch(recursively: false)
        var school = timetable.schools![2]
        try? school.fetch(recursively: false)
        var bachelor = school.levels![0]
        var master = school.levels![1]
        try? bachelor.fetch()
        try? master.fetch()
        
        // Then
        XCTAssertNotNil(bachelor.specializations,
                        "The list of specializations should be initialized after fetching")
        XCTAssertNotNil(master.specializations,
                        "The list of specializations should be initialized after fetching")
        
        // When
        let returnedSpecializationsForBachelors = bachelor.specializations!.map { $0.name }
        let returnedSpecializationsForMasters = master.specializations!.map { $0.name }
        
        // Then
        XCTAssertEqual(expectedSpecializationsForBachelors, returnedSpecializationsForBachelors)
        XCTAssertEqual(expectedSpecializationsForMasters, returnedSpecializationsForMasters)
    }
}
