//
//  ContentView.swift
//  PdfDownload
//
//  Created by Lidiomar Fernando dos Santos Machado on 18/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var downloader = PDFDownloader()
    @State private var downloading = false
    
    var body: some View {
        VStack {
            if let url = downloader.pdfURL {
                PDFViewUI(url: url)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
            } else {
                if downloading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    Button("Download PDF") {
                        downloader.startDownload()
                        downloading = true
                    }
                    .padding()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
