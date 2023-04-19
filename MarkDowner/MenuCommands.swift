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
    
    var titles: [String] = ["h1", "h2", "h3", "h4", "h5", "h6"]
    
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
            .keyboardShortcut("h", modifiers: .control)
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
            .keyboardShortcut("l", modifiers: .command)
            
            Button("Image") {
                let imageText = "![alt text](https://link_to_image)"
                document?.text += imageText
            }
            .keyboardShortcut("i", modifiers: [.control, .shift])
            
            Divider()
            
            Menu("Headers"){
                Button("H1") {
                    let titleText = "# Title \n"
                    document?.text += titleText
                }
                
                Button("H2") {
                    let titleText = "## Title \n"
                    document?.text += titleText
                }
                
                Button("H3") {
                    let titleText = "### Title \n"
                    document?.text += titleText
                }
                
                Button("H4") {
                    let titleText = "#### Title \n"
                    document?.text += titleText
                }
                
                Button("H5") {
                    let titleText = "###### Title \n"
                    document?.text += titleText
                }
                
                Button("H6") {
                    let titleText = "###### Title \n"
                    document?.text += titleText
                }
            }
            
            Divider()
            
            Button("Divider Line") {
                let dividerText = "\n---\n"
                document?.text += dividerText
            }
        }
        
        CommandGroup(after: .importExport) {
            Button("Export HTML...") {
                exportHTML()
            }
            .disabled(document == nil)
            .keyboardShortcut("e", modifiers: .command)
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
