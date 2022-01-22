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
    @Published var rate = 3
    @Published var isFavorite = false
    @Published var showAlert = false
    @Published var alertMessage: String = ""
    var alertTitle: String = ""
    
    func addSong() {
        let songResult = DBManager.shared.addSong(
            coverURL: URL(string: "https://api.lorem.soace/image/album")!,
            lyrics: "bla bla bla",
            title: songTitle,
            rate: Int64(rate),
            releaseDate: releaseDate
        )
        
        switch songResult {
        case .success(let song):
            handleAlert(title: "OK", message: "Song \(song.title ?? "") added")
        case .failure(let error):
            handleAlert(title: "ERROR", message: error.localizedDescription)
        }
    }
    
    func handleAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }
}
