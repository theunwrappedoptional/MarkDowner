//
//  ContentView.swift
//  MarkDowner
//
//  Created by Manhattan on 13/04/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: MarkDownerDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(MarkDownerDocument()))
    }
}
