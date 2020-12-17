//
//  URL+ADBAliasHelpers.swift
//  Boxer
//
//  Created by C.W. Betts on 11/10/20.
//  Copyright © 2020 Alun Bestor and contributors. All rights reserved.
//

import Foundation

extension URL {
    /// Returns 10.6 bookmark data converted from the specified Carbon alias record.
    /// Throws if conversion failed.
    static func bookmarkData(fromAliasRecord aliasRecord: Data) throws -> Data {
        guard let bookmarkDataRef = CFURLCreateBookmarkDataFromAliasRecord(kCFAllocatorDefault, aliasRecord as NSData)?.takeRetainedValue() else {
            throw CocoaError(.fileReadCorruptFile)
        }
        return bookmarkDataRef as Data
    }
    
    /// Creates a URL resolved from the specified Finder alias record.
    ///
    /// Directly equivalent to `URL(resolvingBookmarkData:options:relativeTo:bookmarkDataIsStale:)`.
    init(resolvingAliasRecord aliasRecord: Data, options: URL.BookmarkResolutionOptions = [], relativeTo relativeURL: URL? = nil, bookmarkDataIsStale isStale: inout Bool) throws {
        let bookmarkData = try URL.bookmarkData(fromAliasRecord: aliasRecord)
        try self.init(resolvingBookmarkData: bookmarkData, options: options, relativeTo: relativeURL, bookmarkDataIsStale: &isStale)
    }
}
