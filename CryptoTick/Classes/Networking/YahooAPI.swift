//
//  YahooAPI.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 29/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import Moya
import RxSwift

let yahooProvider = RxMoyaProvider<Yahoo>()

public enum Yahoo {
    case getCurrencies
}

// https://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote
extension Yahoo: TargetType {
    
    func request() -> Observable<Response> {
        return yahooProvider.request(self).filterSuccessfulStatusCodes()
    }
    
    public var baseURL: URL { return URL(string: "https://finance.yahoo.com/webservice/v1/symbols")! }
    
    public var path: String {
        switch self {
        case .getCurrencies:
            return "/allcurrencies/quote"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        return nil
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task: Task {
        return .request
    }
    
    public var sampleData: Data {
        return Data()
    }
}
