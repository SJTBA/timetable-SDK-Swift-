// This file is present only for testing purposes.
// It should be removed when the project is released.

import Foundation
let timetable = Timetable()

try! timetable.fetch(recursively: false)

for var school in timetable.schools! {
    
    print(school.name)
    
    try? school.fetch()
    
    for var level in school.levels! {
        
        print("    " + level.name)
        
        try? level.fetch()
        
        for var specialization in level.specializations! {
            
            print("        " + specialization.name)
        }
    }
}
