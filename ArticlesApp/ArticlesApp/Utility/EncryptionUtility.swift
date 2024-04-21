//
//  EncryptionUtility.swift
//  ArticlesApp
//


import CommonCrypto

class EncryptionUtility {
    static func sha256(_ string: String) -> String {
        guard let data = string.data(using: .utf8) else { return string }
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))

        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }

        return hash.map { String(format: "%02x", $0) }.joined()
    }
}

