//
//  MarkDownerDocument.swift
//  MarkDowner
//
//  Created by Manhattan on 13/04/23.
//

import SwiftUI
import UniformTypeIdentifiers
import MarkdownKit

extension UTType {
    static var markdownText: UTType {
        UTType(importedAs: "net.daringfireball.markdown")
    }
}

struct MarkDownerDocument: FileDocument {
    var text: String
    var html: String {
        let markdown = MarkdownParser.standard.parse(text)
        return HtmlGenerator.standard.generate(doc: markdown)
    }

    init(text: String = "# Hello, Markdowner!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.markdownText] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
