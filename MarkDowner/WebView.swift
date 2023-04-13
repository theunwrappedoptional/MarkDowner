//
//  WebView.swift
//  MarkDowner
//
//  Created by Manhattan on 13/04/23.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    
    var html: String
    
    init(html: String) {
        self.html = html
    }
    
    func makeNSView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(html, baseURL: Bundle.main.resourceURL)
    }
    
}
