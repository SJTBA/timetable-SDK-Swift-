// This file is present only for testing purposes.
// It should be removed when the project is released.

import Foundation
let timetable = Timetable()

try! timetable.fetch()

for (name, url) in timetable.faculties! {
    print("Факультет: \(name)\nCтраница: \(url.absoluteString)\n")
}
