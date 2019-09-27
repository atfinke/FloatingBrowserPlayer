//
//  ContentView.swift
//  FloatingBrowser
//
//  Created by Andrew Finke on 9/21/19.
//  Copyright © 2019 Andrew Finke. All rights reserved.
//

import SwiftUI
import WebKit

struct _HackStorage {
    static var urlString: String = ""
}

struct WebView : NSViewRepresentable  {

    typealias NSViewType = WKWebView

    @Binding var urlString: String
    @Binding var isHovering: Bool

    func makeNSView(context: NSViewRepresentableContext<WebView>) -> WebView.NSViewType {
        let view = WKWebView()
        return view
    }

    func updateNSView(_ nsView: WebView.NSViewType, context: NSViewRepresentableContext<WebView>) {
        if !isHovering, urlString != _HackStorage.urlString, let url = URL(string: urlString) {
            _HackStorage.urlString = urlString
            let request = URLRequest(url: url)
            nsView.load(request)
        }
    }
}


struct ContentView : View {

    var showURLBar = false

    @State var urlString: String = "https://play.hbogo.com/"
    @State var isHovering = false

    var body: some View {
        ZStack(alignment: .bottom) {
            WebView(urlString: $urlString, isHovering: $isHovering)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            if isHovering {
                ZStack {
                    Color.black
                        .frame(height: 50)
                    TextField("url", text: $urlString)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .padding(5)
                }
            }
        }.onHover { isHovering in
            self.isHovering = isHovering
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
