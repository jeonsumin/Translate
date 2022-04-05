//
//  TranslateRequestModel.swift
//  Translate
//
//  Created by Terry on 2022/04/05.
//

import Foundation

struct TranslateRequestModel: Codable {
    let source: String
    let target: String
    let text: String 
}
