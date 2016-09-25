//
//  _HTMLRepresentable.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 25.09.16.
//
//

import Foundation
import Scrape

internal protocol _HTMLRepresentable {
    
    var _html: String? { get set }
    var _page: HTMLDocument? { get set }
}

internal extension _HTMLRepresentable {
    
    internal mutating func getHTML(for url: URL) throws {
        _html = try String(contentsOf: url, encoding: .utf8)
    }
    
    internal mutating func parseHTML() throws {
        
        guard let html = _html else { throw FetchingError.parseError }
        
        if let document = HTMLDocument(html: html, encoding: .utf8) {
            _page = document
        } else {
            throw FetchingError.parseError
        }
    }
}
