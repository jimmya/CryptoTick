//
//  CTStatusBarButton.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 30/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Cocoa

final class CTStatusBarView: NSView {
    
    let graphView = CTGraphView()
    var onMouseDown: (() -> Void)?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        graphView.frame = frameRect
        addSubview(graphView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if let onMouseDownBlock = onMouseDown {
            onMouseDownBlock()
        }
    }
}
