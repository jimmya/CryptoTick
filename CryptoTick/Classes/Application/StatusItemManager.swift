//
//  StatusItemManager.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 29/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Cocoa
import RxSwift

final class StatusItemManager: NSObject {

    static let shared = StatusItemManager()
    private let optionsMenuItem = NSMenuItem()
    private let coinsMenu = NSMenu()
    private let disposeBag = DisposeBag()
    private var statusView: CTStatusBarView?
    
    let statusItem: NSStatusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var statusItemFrame: NSRect {
        return statusItem.view?.frame ?? NSRect()
    }
    
    override init() {
        super.init()
        CurrencyManager.shared.currencies
            .asObservable()
            .subscribe(onNext: { [weak self] (currencies) in
                let currenciesMenu = NSMenu()
                for currency in currencies {
                    let menuItem = NSMenuItem()
                    menuItem.title = currency.cleanSymbol
                    menuItem.target = self
                    currenciesMenu.addItem(menuItem)
                }
                self?.optionsMenuItem.submenu = currenciesMenu
                }, onError: { (error) in
                    
            }).addDisposableTo(disposeBag)
        
        CurrencyManager.shared.coins
            .asObservable()
            .subscribe(onNext: { [weak self] (coins) in
                guard let strongSelf = self else {
                    return
                }
                self?.coinsMenu.removeAllItems()
                for coin in coins {
                    let menuItem = CTCoinMenuItem(coin: coin, action: #selector(strongSelf.selectCoin(sender:)), keyEquivalent: "")
                    menuItem.target = strongSelf
                    if coin.shortName == CurrencyManager.shared.selectedCoin {
                        menuItem.state = NSOnState
                    }
                    self?.coinsMenu.addItem(menuItem)
                }
                }, onError: { (error) in
                    
            }).addDisposableTo(disposeBag)
        
        CurrencyManager.shared.priceGraph
            .asObservable()
            .subscribe(onNext: { [weak self] (priceGraph) in
                self?.statusView?.graphView.priceGraph = priceGraph
                }, onError: { (error) in
                    
            }).addDisposableTo(disposeBag)
    }

    func setupStatusBarButton() {
        let rect = NSRect(x: 0, y: 0, width: 50, height: NSStatusBar.system().thickness)
        statusView = CTStatusBarView(frame: rect)
        statusView?.wantsLayer = true
        statusView?.onMouseDown = { [weak self] () in
            if let statusItemMenu = self?.statusItem.menu {
                self?.statusItem.popUpMenu(statusItemMenu)
            }
        }
        statusItem.view = statusView
        
        let menu = NSMenu()
        menu.delegate = self
        optionsMenuItem.title = "Options"
        optionsMenuItem.target = self
        menu.addItem(optionsMenuItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let coinsMenuItem = NSMenuItem()
        coinsMenuItem.title = "Coins"
        coinsMenuItem.target = self
        coinsMenuItem.submenu = coinsMenu
        menu.addItem(coinsMenuItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(terminate), keyEquivalent: "")
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)
        statusItem.menu = menu
    }
	
    func openTestTitle() {
        
    }
    
    func terminate() {
        NSApplication.shared().terminate(self)
    }
    
    func selectCoin(sender: CTCoinMenuItem) {
        if let shortName = sender.coin?.shortName {
            CurrencyManager.shared.selectedCoin = shortName
        }
    }
}

extension StatusItemManager: NSMenuDelegate {
    
    func menuWillOpen(_ menu: NSMenu) {
        statusItem.drawStatusBarBackground(in: statusItemFrame, withHighlight: true)
    }
    
    func menuDidClose(_ menu: NSMenu) {
        statusItem.drawStatusBarBackground(in: statusItemFrame, withHighlight: false)
    }
}

