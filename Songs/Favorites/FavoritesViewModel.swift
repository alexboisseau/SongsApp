//
//  FavoritesViewModel.swift
//  Songs
//
//  Created by Alex Boisseau on 22/01/2022.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    init() {
        fetchSongs()
    }
    
    func fetchSongs() -> Void {
        let songsResult = DBManager.shared.getAllSongs(predicate: NSPredicate(format: "isFavorite == %@", NSNumber(value: true)))
        
        switch songsResult {
        case .failure: return
        case .success(let songs):
            self.songs = songs
        }
    }
    
    func removeSongFromFavorites(song: Song) {
        song.isFavorite = false
        DBManager.shared.updateSong(song: song)
    }
}
