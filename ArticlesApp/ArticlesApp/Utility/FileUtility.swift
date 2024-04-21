//
//  FileUtility.swift
//  ArticlesApp
//


import Foundation

class FileUtility {
    static let shared = FileUtility()
    
    private let cacheDirectory: URL
    
    init() {
        
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError("Unable to access cache directory.")
        }
        self.cacheDirectory = cacheDirectory.appendingPathComponent("DataCache", isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: self.cacheDirectory.path) {
            do {
                try FileManager.default.createDirectory(at: self.cacheDirectory, withIntermediateDirectories: true)
            } catch {
                fatalError("Failed to create cache directory: \(error)")
            }
        }
    }
    
    func saveImageData(_ data: Data, forFileName fileName: String) {
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("Error writing data to disk cache: \(error)")
        }
    }
    
    func getImageData(forFileName fileName: String) -> Data? {
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            print("Error reading data from disk cache: \(error)")
            return nil
        }
    }
}
