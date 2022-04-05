//
//  TranslatorManager.swift
//  Translate
//
//  Created by Terry on 2022/04/05.
//

import Alamofire // AFNetworking, URLSession
import Foundation

struct TranslatorManager {
    var sourceLanguage: Language = .ko
    var targetLanguage: Language = .en
    
    func translate(from text: String,completionHandler: @escaping (String) -> Void ) {
        
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
        //url이 존재한다는 담보가 되어있음,
        
        let requestModel = TranslateRequestModel(source: sourceLanguage.languageCode,
                                                 target: targetLanguage.languageCode,
                                                 text: text)
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "YvHZRKtBlg2jtzbHtVwX",
            "X-Naver-Client-Secret": "rBxQ9vR7je"
        ]
        AF.request(url, method: .post, parameters: requestModel, headers: headers)
            .responseDecodable(of: TranslateResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.translateText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
