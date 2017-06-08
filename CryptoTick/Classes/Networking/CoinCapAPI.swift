//
//  CoinCapAPI.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 29/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import Moya
import RxSwift

let coincapProvider = RxMoyaProvider<CoinCap>()

public enum CoinCap {
    case getGlobal
    case getCoins
    case getFront
    case getHistory(coin: String)
}

extension CoinCap: TargetType {
    
    func request() -> Observable<Response> {
        return coincapProvider.request(self).filterSuccessfulStatusCodes()
    }
    
    public var baseURL: URL { return URL(string: "http://www.coincap.io")! }
    
    public var path: String {
        switch self {
        case .getGlobal:
            return "/global"
        case .getCoins:
            return "/coins"
        case .getFront:
            return "/front"
        case .getHistory(let coin):
            return "/history/1day/\(coin)"
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
