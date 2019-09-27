//
//  AppDelegate.swift
//  FloatingBrowser
//
//  Created by Andrew Finke on 9/21/19.
//  Copyright © 2019 Andrew Finke. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [
                .titled,
                .closable,
                .miniaturizable,
                .resizable,
                .fullSizeContentView
            ],
            backing: .buffered,
            defer: false)

        window.contentView = NSHostingView(rootView: ContentView())
        window.makeKeyAndOrderFront(nil)

        window.level = .floating
        window.collectionBehavior = .canJoinAllSpaces

        window.alphaValue = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.window.center()
            self.window.alphaValue = 1.0
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

