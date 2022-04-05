//
//  TranslateResponseModel.swift
//  Translate
//
//  Created by Terry on 2022/04/05.
//

import Foundation

struct TranslateResponseModel: Codable {
    private let message: Message
    
    var translateText: String { message.result.translatedText }
    
    struct Message: Codable {
        let result: Result
    }
    
    struct Result: Codable {
        let translatedText: String
    }
}
