//
//  SongDataProcessor.swift
//  my-first-app
//
//  Created by user146790 on 12/1/18.
//  Copyright © 2018 user146790. All rights reserved.
//

import Foundation

class SongDataProcessor {
    
    static func mapJsonToSongs(object: [String: AnyObject], key: String) -> [Song] {
        var mappedSongs: [Song] = []
        
        guard let songs = object[key] as? [[String: AnyObject]] else { return mappedSongs }
        
        for song in songs {
            guard let id = song["id"] as? String,
                let name = song["name"] as? String,
                let artistName = song["artistName"] as? String,
                let albumName = song["albumName"] as? String,
                let previewURL = song["previewURL"] as? String
                else { continue }
            
            let songClass = Song(id: id, name: name, artistName: artistName, albumName: albumName, previewURL: previewURL)
            mappedSongs.append(songClass)
        }

        return mappedSongs
    }
}
