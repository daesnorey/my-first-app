//
//  Song.swift
//  my-first-app
//
//  Created by user146790 on 12/1/18.
//  Copyright © 2018 user146790. All rights reserved.
//

import Foundation

class Song {
    
    var id: String!
    var name: String!
    var artistName: String!
    var albumName: String!
    var previewURL: String!
    
    init(id: String, name: String, artistName: String, albumName: String, previewURL: String) {
        self.id = id
        self.name = name
        self.artistName = artistName
        self.albumName = albumName
        self.previewURL = previewURL
    }
}
