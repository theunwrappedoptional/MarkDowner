//
//  WebView.swift
//  MarkDowner
//
//  Created by Manhattan on 13/04/23.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    
    var html: String?
    var address: String?
    
    @AppStorage("styleSheet") var styleSheet: StyleSheet = .raywenderlich
    
    var formattedHtml: String {
        return """
            <html>
            <head>
                <link href="\(styleSheet).css" rel="stylesheet">
            </head>
            <body>
                \(html ?? "")
            </body>
            </html>
            """
    }
    
    init(html: String?, address: String? = nil) {
        self.html = html
        self.address = address
    }
    
    func makeNSView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        if html != nil {
            nsView.loadHTMLString(formattedHtml, baseURL: Bundle.main.resourceURL)
        } else if let address = address, let url = URL(string: address){
            let request = URLRequest(url: url)
            nsView.load(request)
        }
    }
}
