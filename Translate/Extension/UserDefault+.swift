//
//  UserDefault+.swift
//  Translate
//
//  Created by Terry on 2022/04/05.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case bookmarks
    }
    
    var boockmarks: [Bookmark] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.bookmarks.rawValue) else { return [] }
            return (try? PropertyListDecoder().decode([Bookmark].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue),
                                           forKey: Key.bookmarks.rawValue)
        }
    }
}
