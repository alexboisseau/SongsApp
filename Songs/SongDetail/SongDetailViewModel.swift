//
//  SongDetailViewModel.swift
//  Songs
//
//  Created by Alex Boisseau on 25/01/2022.
//

import SwiftUI

class SongDetailViewModel: ObservableObject {
    @Published var song: Song
    
    init(song: Song) {
        self.song = song
    }
}
