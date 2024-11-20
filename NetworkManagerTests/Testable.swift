//
//  Testable.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import Foundation

protocol Testable {
    var bundle: Bundle { get }
    func loadMockJson<T: Decodable>(filename: String, model: T.Type) -> T
}

extension Testable {
    var bundle: Bundle {
        return Bundle(for: type(of: Self.self))
    }
    
    func loadMockJson<T: Decodable>(filename: String, model: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else { fatalError("Failed to load \(filename)") }

       do {
           let data = try Data(contentsOf: path)
           let jsonDecoder = JSONDecoder()
           let decodedObject = try jsonDecoder.decode(model, from: data)

           return decodedObject
       } catch {
           fatalError("Failed to decode \(filename)")
       }
    }
}
