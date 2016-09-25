// This file is present only for testing purposes.
// It should be removed when the project is released.

import Foundation
import TimetableSDKSwift

let testLocally = true

let localURL = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent().appendingPathComponent("Resources/index.html")

let timetable = try! testLocally ? Timetable(url: localURL) : Timetable()

try! timetable.fetch(recursively: false)

for var school in timetable.schools ?? [] {
    
    print(school.name)
    
    try? school.fetch()
    
    for var level in school.levels ?? [] {
        
        print("|-- " + level.name)
        
        try? level.fetch()
        
        for var specialization in level.specializations ?? [] {
            
            print("|   |-- " + specialization.name)
        }
    }
}
