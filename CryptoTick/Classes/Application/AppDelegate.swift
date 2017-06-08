//
//  AppDelegate.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 29/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Cocoa

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        StatusItemManager.shared.setupStatusBarButton()
        CurrencyManager.shared.scheduleCurrencyLoading()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
}
