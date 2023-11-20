//
//  AlbumViewModel.swift
//  TestHD
//
//  Created by George Gomes on 20/11/23.
//

import Foundation

protocol AlbumViewModelProtocol {
    var albums: [Album] { get }
    func callAlbums() async
    func callImageFrom(urlString: String) async throws -> Data
}

class AlbumViewModel: AlbumViewModelProtocol {
    
    private let service: ServiceProtocol
    private(set) var albums: [Album] = []
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func callAlbums() async {
        do {
            self.albums = try await service.requestAlbums()
        } catch {
            // handle error
        }
    }
    
    func callImageFrom(urlString: String) async throws -> Data {
        return try await service.callImageFrom(urlString: urlString)
    }
}
