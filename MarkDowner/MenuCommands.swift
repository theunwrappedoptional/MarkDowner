//
//  MenuCommands.swift
//  MarkDowner
//
//  Created by Manhattan on 14/04/23.
//

import SwiftUI

struct MenuCommands: Commands {
    
    @FocusedBinding(\.document) var document
    
    @AppStorage("styleSheet") var styleSheet: StyleSheet = .raywenderlich
    @AppStorage("editorFontSize") var editorFontSize: Double = 14
    
    var body: some Commands {
        CommandMenu("Display"){
            ForEach(StyleSheet.allCases, id: \.self) { style in
                Button {
                    styleSheet = style
                } label: {
                    Text(style.rawValue)
                        .foregroundColor(style == styleSheet ? .accentColor : .primary)
                }
                .keyboardShortcut(KeyEquivalent(style.rawValue.first!))
            }
            
            Divider()
            
            Menu("Font Size") {
                Button("Smaller") {
                    if editorFontSize > 8 {
                        editorFontSize -= 1
                    }
                }
                .keyboardShortcut("-")
                
                Button("Reset") {
                    editorFontSize = 14
                }
                .keyboardShortcut("0")
                
                Button("Larger") {
                    editorFontSize += 1
                }
                .keyboardShortcut("+")
            }
        }
        
        CommandGroup(replacing: .help) {
            NavigationLink {
                WebView(html: nil, address:"https://bit.ly/3x55SNC")
                    .frame(minWidth:600, minHeight: 600)
            } label: {
                Text("Markdown Help")
            }
        }
        
        CommandMenu("Markdown") {
            Button("Bold") {
                document?.text += "**BOLD**"
            }
            .keyboardShortcut("b")
            
            Button("Italic") {
                document?.text += "_Italic_"
            }
            .keyboardShortcut("i", modifiers: .command)
            
            Button("Link") {
                let linkText = "[Title](https://link_to_page)"
                document?.text += linkText
            }
            
            Button("Image") {
                let imageText = "![alt text](https://link_to_image)"
                document?.text += imageText
            }
            
        }
        
        CommandGroup(after: .importExport) {
            Button("Export HTML...") {
                exportHTML()
            }
            .disabled(document == nil)
        }
    }
    
    func exportHTML(){
        guard let document = document else {
            return
        }
        
        let savePanel = NSSavePanel()
        savePanel.title = "Save HTML"
        savePanel.nameFieldStringValue = "Export.html"
        
        savePanel.begin { response in
            if response == .OK, let url = savePanel.url {
                try? document.html.write(to: url, atomically: true, encoding: .utf8)
            }
        }
    }
}
