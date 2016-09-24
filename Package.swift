import PackageDescription

let package = Package(
    name: "Timetable-SDK-Swift",
    dependencies: [
        .Package(url: "https://github.com/WeirdMath/Scrape.git", majorVersion: 1)
    ]
)
