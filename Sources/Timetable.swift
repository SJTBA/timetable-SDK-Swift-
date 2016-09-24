//
//  Timetable.swift
//  Timetable-SDK-Swift
//
//  Created by Sergej Jaskiewicz on 24.09.16.
//
//

import Foundation
import Scrape

open class Timetable {
    
    private let _mainURL: URL
    private var _mainHTML: String?
    private var _mainPage: HTMLDocument?
    
    public init(url: URL = URL(string: "http://timetable.spbu.ru")!) {
        _mainURL = url
    }
    
    private func getHTML(for url: URL) throws {
        _mainHTML = try String(contentsOf: url, encoding: .utf8)
    }
    
    open func fetch(recursively: Bool = false) throws {
        
        try getHTML(for: _mainURL)
        
        if let document = HTMLDocument(html: _mainHTML!, encoding: .utf8) {
            _mainPage = document
        } else {
            throw FetchingError.parseError
        }
    }
    
    
    
    private lazy var _faculties: [(name: String, url: URL)]? = {
        return self._mainPage?
            .search(byXPath: .facultyRows)
            .map { (name: $0.text ?? "nil", url: self._mainURL.appendingPathComponent($0["href"] ?? "")) }
    }()
    
    open var faculties: [(name: String, url: URL)]? {
        return _faculties
    }
}
