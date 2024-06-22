//
//  PDFViewUI.swift
//  PdfDownload
//
//  Created by Lidiomar Fernando dos Santos Machado on 18/06/24.
//

import SwiftUI
import PDFKit

struct PDFViewUI: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if let document = PDFDocument(url: url) {
            uiView.document = document
        }
    }
}
