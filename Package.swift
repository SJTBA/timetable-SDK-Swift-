import PackageDescription

let package = Package(
    name: "Timetable-SDK-Swift",
    // FIXME: This should be removed when the project is released.
    targets: [
        Target(name: "TimetableSDKSwift"),
        Target(name: "Runner", dependencies: ["TimetableSDKSwift"])
    ],
    dependencies: [
        .Package(url: "https://github.com/WeirdMath/Scrape.git", majorVersion: 1)
    ]
)
