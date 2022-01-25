//
//  AffArtistViewModel.swift
//  Songs
//
//  Created by Alex Boisseau on 23/01/2022.
//

import SwiftUI

class AddArtistViewModel: ObservableObject {
    @Published var artists = [Artist]()
    @Published var addArtistFormIsShow = false
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var showAlert = false
    @Published var alertMessage: String = ""
    var alertTitle: String = ""
    
    
    init() {
        fetchArtists()
    }
    
    func fetchArtists() {
        let artistsResult = DBManager.shared.getAllArtists()
        
        switch artistsResult {
        case .success(let artists): self.artists = artists
        case .failure: return
        }
    }
    
    func addNewArtist() {
        let artistResult = DBManager.shared.addArtist(firstName: self.firstName, lastName: self.lastName, coverURL: URL(string: "https://api.lorem.space/image/album?w=150&h=150")!, songs: [Song]())
        
        switch artistResult {
        case .success(let artist):
            if let firstName = artist.firstName, let lastName = artist.lastName {
                handleAlert(title: "Success ✨", message: "\(firstName) \(lastName) added")
            } else {
                handleAlert(title: "Success ✨", message: "A new artist was added")
            }
        case .failure(let error):
            handleAlert(title: "Oups ... Something went wrong", message: error.localizedDescription)
        }
    }
    
    func handleAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }
}
