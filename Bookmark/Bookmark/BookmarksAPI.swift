//
//  BookmarksAPI.swift
//  Bookmark
//
//  Created by Alikhan Tangirbergen on 14.08.2023.
//

import Foundation

class BookmarksAPI {
    static func getBookmarks() -> [Bookmark] {
        if let bookmarkData = UserDefaults.standard.data(forKey: "bookmarks"),
           let savedBookmarks = try? JSONDecoder().decode([Bookmark].self, from: bookmarkData) {
            userBookmarks = savedBookmarks
            return userBookmarks
        }
        return []
    }
}
