//
//  CTStatusBarButton.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 30/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Cocoa

final class CTStatusBarView: NSView {
    
    let graphView: CTGraphView
    var onMouseDown: (() -> Void)?
    
    override init(frame frameRect: NSRect) {
        graphView = CTGraphView(frame: frameRect)
        super.init(frame: frameRect)
        addSubview(graphView)
    }
    
    required init?(coder: NSCoder) {
        graphView = CTGraphView()
        super.init(coder: coder)
        addSubview(graphView)
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if let onMouseDownBlock = onMouseDown {
            onMouseDownBlock()
        }
    }
}
