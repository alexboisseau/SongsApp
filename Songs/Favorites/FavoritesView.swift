//
//  FavoritesView.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        
        NavigationView {
            if viewModel.songs.isEmpty {
                HStack {
                    Spacer()
                    Text("You don't have favorite songs 😢")
                    Spacer()
                }
                .navigationTitle("Favorites ❤️")
            } else {
                List {
                    ForEach(viewModel.songs) { song in
                        if let title = song.title, let songArtist = song.artist {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(title)
                                    Text(songArtist.firstName ?? "No artist")
                                        .font(.caption)
                                }
                                Spacer()
                                Button {
                                    viewModel.removeSongFromFavorites(song: song)
                                    viewModel.fetchSongs()
                                } label: {
                                    Image(systemName: "heart.fill")
                                }
                            }
                        }
                        
                    }
                }
                .navigationTitle("Favorites ❤️")
            }
        }
        .onAppear {
            viewModel.fetchSongs()
        }
    }
}
