//
//  Service.swift
//  TestHD
//
//  Created by George Gomes on 20/11/23.
//

import Foundation

protocol ServiceProtocol {
    func requestAlbums() async throws -> [Album]
    func callImageFrom(urlString: String) async throws -> Data 
}

class Service: ServiceProtocol {
    
    private let baseURLString = "https://jsonplaceholder.typicode.com/photos"
    
    func requestAlbums() async throws -> [Album] {
        
        guard let url = URL(string: baseURLString) else {
           // throw ServiceError.urlWrong
            throw NSError(domain: "url fail", code: 0)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NSError(domain: "response fail", code: 1)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Album].self, from: data)
        } catch {
            print(error)
            throw NSError(domain: "decode fail", code: 2)
        }
    }
    
    func callImageFrom(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
           // throw ServiceError.urlWrong
            throw NSError(domain: "url fail", code: 0)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NSError(domain: "response fail", code: 1)
        }
        
        return data
    }
}

