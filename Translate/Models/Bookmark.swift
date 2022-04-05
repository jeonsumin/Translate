//
//  Bookmark.swift
//  Translate
//
//  Created by Terry on 2022/04/05.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    
    let sourceText: String
    let translatedText: String

}

