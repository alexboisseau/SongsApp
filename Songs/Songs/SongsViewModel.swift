//
//  SongsViewModel.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

class SongsViewModel: ObservableObject {
    @Published var showSheet = false
    @Published var showAddSongView = false
    @Published var songs = [Song]()
    @Published var showSongInformations = false
    @Published var selectedSong: Song? = nil
    
    init() {
        fetchSongs()
    }
    
    func fetchSongs() -> Void {
        let songsResult = DBManager.shared.getAllSongs()
        
        switch songsResult {
        case .failure: return
        case .success(let songs):
            self.songs = songs
        }
    }
    
    func deleteSong(at offsets: IndexSet) {
        offsets.forEach { index in
            DBManager.shared.deleteSong(by: songs[index].objectID)
        }
        songs.remove(atOffsets: offsets)
    }
    
    func toggleIsFavoriteSongProperty(song: Song) {
        song.isFavorite.toggle()
        DBManager.shared.updateSong(song: song)
    }
}
