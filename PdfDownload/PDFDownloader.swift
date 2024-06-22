//
//  PdfDownloader.swift
//  PdfDownload
//
//  Created by Lidiomar Fernando dos Santos Machado on 18/06/24.
//

import Foundation

class PDFDownloader: NSObject, ObservableObject {
    @Published var pdfURL: URL?
    var downloadTask: URLSessionDownloadTask?
    var urlSession: URLSession?

    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }

    func startDownload() {
        if let cacheURL = getCachedPDFURL() {
            // If the file is already in the cache, use it
            self.pdfURL = cacheURL
            print("Using cached file at \(cacheURL)")
        } else if let url = URL(string: "https://www.learningcontainer.com/wp-content/uploads/2019/09/sample-pdf-download-10-mb.pdf") {
            // Otherwise, start downloading the file
            downloadTask = urlSession?.downloadTask(with: url)
            downloadTask?.resume()
        }
    }
    
    private func getCachedPDFURL() -> URL? {
        let fileManager = FileManager.default
        do {
            let cacheURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let savedURL = cacheURL.appendingPathComponent("sample.pdf")
            if fileManager.fileExists(atPath: savedURL.path) {
                return savedURL
            }
        } catch {
            print("Cache directory error: \(error)")
        }
        return nil
    }
}

extension PDFDownloader: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        // Handle the file move and error handling here
        let fileManager = FileManager.default
        do {
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let savedURL = documentsURL.appendingPathComponent("sample.pdf")
            try fileManager.moveItem(at: location, to: savedURL)
            DispatchQueue.main.async {
                self.pdfURL = savedURL
            }
            print("File saved to \(savedURL)")
        } catch {
            print("File error: \(error)")
        }
    }
}
