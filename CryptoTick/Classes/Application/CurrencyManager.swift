//
//  CurrencyManager.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 31/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import RxSwift
import SWXMLHash
import SocketIO
import JASON

final class CurrencyManager {
    
    static let shared = CurrencyManager()
    var currencies: Variable = Variable<[Currency]>([])
    var coins: Variable = Variable<[Coin]>([])
    var priceGraph: Variable = Variable<[DataPoint]>([])
    var selectedCoin: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedCoin")
            loadCurrencies()
        }
        get {
            return UserDefaults.standard.value(forKey: "selectedCoin") as? String ?? "BTC"
        }
    }
    var selectedCurrency: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedCurrency")
            loadCurrencies()
        }
        get {
            return UserDefaults.standard.value(forKey: "selectedCurrency") as? String ?? "EUR"
        }
    }
    var selectedCurrencyRate: Double? {
        for currency in currencies.value {
            if currency.cleanSymbol == selectedCurrency {
                return currency.price
            }
        }
        return nil
    }
    
    private let disposeBag = DisposeBag()
    private let socket = SocketIOClient(socketURL: URL(string: "http://socket.coincap.io")!)
    
    init() {
        
    }
    
    func scheduleCurrencyLoading() {
        loadCurrencies()
        Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(loadCurrencies), userInfo: nil, repeats: true)
        
        CoinCap.getFront
            .request()
            .map(to: [Coin.self])
            .subscribe(onNext: { [weak self] (coins) in
                self?.coins.value = coins
                }, onError: { (error) in
                    
            }).addDisposableTo(disposeBag)
        
        socket.on("trades") { [weak self] (data, ack) in
            data.flatMap({ (currentItem) -> Trade? in
                if let current = currentItem as? [String: Any],
                    let message = current["message"] as? [String: Any] {
                    return Trade(dictionary: message)
                }
                return nil
            }).forEach({ (trade) in
                if let shortName = trade.coin?.shortName, let newPrice = trade.coin?.price {
                    self?.coins.value.updatePriceForCoin(withShortName: shortName, newPrice: newPrice)
                }
            })
        }
        socket.connect()
    }
    
    @objc func loadCurrencies() {
        CoinCap.getHistory(coin: selectedCoin)
            .request()
            .map(to: History.self)
            .subscribe(onNext: { [weak self] (history) in
                self?.priceGraph.value = history.price ?? []
                }, onError: { (error) in
                    
            }).addDisposableTo(disposeBag)
        
        Yahoo.getCurrencies.request().subscribe(onNext: { [weak self] (response) in
            let xml = SWXMLHash.parse(response.data)
            self?.currencies.value = xml["list"]["resources"]["resource"].all.flatMap({ (resource) -> Currency? in
                return Currency(xml: resource)
            })
        }, onError: { (error) in
            print(error)
        }).addDisposableTo(disposeBag)
    }
}
