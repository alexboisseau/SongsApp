//
//  AddSongViewModel.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

class AddSongViewModel: ObservableObject {
    @Published var songTitle = ""
    @Published var releaseDate = Date()
    @Published var rate: Int64 = 3
    @Published var isFavorite = false
    @Published var showAlert = false
    @Published var alertMessage: String = ""
    @Published var artist: Artist? = nil
    
    var alertTitle: String = ""
    
    func addSong() {
        
        if let unwrappedArtist = artist {
            let songResult = DBManager.shared.addSong(
                coverURL: URL(string: "https://api.lorem.space/image/album?w=150&h=150")!,
                lyrics: "bla bla bla",
                title: songTitle,
                rate: rate,
                releaseDate: releaseDate,
                isFavorite: isFavorite,
                artist: unwrappedArtist
            )
            
            switch songResult {
            case .success(let song):
                handleAlert(title: "OK", message: "Song \(song.title ?? "") added")
            case .failure(let error):
                handleAlert(title: "ERROR", message: error.localizedDescription)
            }
        } else {
            handleAlert(title: "Error", message: "You need to add an artist")
        }
        
    }
    
    func handleAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }
}
