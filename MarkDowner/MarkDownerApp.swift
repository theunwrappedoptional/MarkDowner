//
//  MarkDownerApp.swift
//  MarkDowner
//
//  Created by Manhattan on 13/04/23.
//

import SwiftUI

@main
struct MarkDownerApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: MarkDownerDocument()) { file in
            ContentView(document: file.$document)
                .focusedValue(\.document, file.$document)
        }
        .commands{
            MenuCommands()
        }
    }
}
