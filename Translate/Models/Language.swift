//
//  Language.swift
//  Translate
//
//  Created by Terry on 2022/03/11.
//

import Foundation

enum Language: String, Codable, CaseIterable {
    case ko
    case en
    case ja
    case ch = "zh-CN"
    case ru
    case es
    case de
    case it
    case fr
    
    var title: String {
        switch self {
        case .ko:
            return "한국어"
        case .en:
            return "영어"
        case .ja:
            return "일본어"
        case .ch:
            return "중국어"
        case .ru:
            return "러시아어"
        case .es:
            return "스페인어"
        case .de:
            return "독일어"
        case .it:
            return "이탈리아어"
        case .fr:
            return "프랑스어"
        }
    }
    
    var languageCode: String {
        self.rawValue
    }
}

