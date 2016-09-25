// This file is present only for testing purposes.
// It should be removed when the project is released.

import Foundation
let timetable = Timetable()

try! timetable.fetch(recursively: true)

for school in timetable.schools! {
    
    print("Faculty: \(school.name)\nPage: \(school.url.absoluteString)\n")
    
    print("Levels:\n")
    
    for level in school.levels! {
        print(level.name)
    }
    
    print("\n\n")
}
