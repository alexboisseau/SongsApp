//
//  ArtistsViewModel.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

class ArtistsViewModel: ObservableObject {
    @Published var showAddArtist = false
    @Published var artists = [Artist]()
    
    init() {
        fetchArtists()
    }
    
    func fetchArtists() -> Void {
        let artistsResult = DBManager.shared.getAllArtists()
        
        switch artistsResult {
        case .failure: return
        case .success(let artists): self.artists = artists
        }
    }
}
