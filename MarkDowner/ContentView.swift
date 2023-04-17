//
//  ContentView.swift
//  MarkDowner
//
//  Created by Manhattan on 13/04/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: MarkDownerDocument
    
    @State private var previewState = PreviewState.web
    @AppStorage("editorFontSize") var editorFontSize: Double = 14

    var body: some View {
        HSplitView{
            TextEditor(text: $document.text)
                .frame(minWidth: 200)
            if previewState == .web {
                WebView(html: document.html)
                    .frame(minWidth: 200)
            } else if previewState == .code {
                ScrollView{
                    Text(document.html)
                        .frame(minWidth: 200)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                        .textSelection(.enabled)
                }
            }
        }
        .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity, minHeight: 300, idealHeight: 400, maxHeight: .infinity)
        .font(.system(size: editorFontSize))
        .toolbar{
            ToolbarItem{
                Picker("", selection: $previewState){
                    Image(systemName: "network")
                        .tag(PreviewState.web)
                    Image(systemName: "chevron.left.forwardslash.chevron.right")
                        .tag(PreviewState.code)
                    Image(systemName: "nosign")
                        .tag(PreviewState.off)
                }
                .pickerStyle(.inline)
                .help("Hide preview, show HTML or web view")
            }
        }
    }
}

enum PreviewState {
    case web
    case code
    case off
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(MarkDownerDocument()))
    }
}
