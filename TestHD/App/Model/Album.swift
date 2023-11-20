//
//  Album.swift
//  TestHD
//
//  Created by George Gomes on 20/11/23.
//

import Foundation

struct Album: Decodable {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
}
