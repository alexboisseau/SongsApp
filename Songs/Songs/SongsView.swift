//
//  SongsView.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

struct SongsView: View {
    @ObservedObject private var viewModel = SongsViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.songs.isEmpty {
                HStack {
                    Spacer()
                    Text("Add a new song 🎉")
                    Spacer()
                }
                .navigationTitle("Songs 🎵")
                .navigationBarItems(
                    trailing:
                        Button {
                            viewModel.showAddSongView = true
                            viewModel.showSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                )

            } else {
                List {
                    ForEach(viewModel.songs) { song in
                        if let title = song.title {
                            Button {
                                // SHOW SONG INFORMATIONS
                                viewModel.selectedSong = song
                                viewModel.showSongInformations = true
                                viewModel.showSheet.toggle()
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(title)
                                        Text(song.artist?.firstName ?? "No artist")
                                            .font(.caption)
                                    }
                                    Spacer()
                                    Button {
                                        viewModel.toggleIsFavoriteSongProperty(song: song)
                                        viewModel.fetchSongs()
                                    } label: {
                                        Image(systemName: song.isFavorite ? "heart.fill" : "heart")
                                    }
                                    .foregroundColor(.accentColor)
                                }
                            }
                            .foregroundColor(.primary)
                        }
                        
                    }.onDelete { offsets in
                        viewModel.deleteSong(at: offsets)
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Songs 🎵")
                .animation(.easeInOut, value: viewModel.songs)
                .navigationBarItems(
                    trailing:
                        Button {
                            viewModel.showAddSongView = true
                            viewModel.showSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                )
            }
        }
        .sheet(isPresented: $viewModel.showSheet) {
            viewModel.showSongInformations = false
            viewModel.showAddSongView = false
            
            viewModel.fetchSongs()
        } content: {
            if viewModel.showAddSongView {
                AddSongView()
            } else {
                SongDetailView(song: $viewModel.selectedSong)
            }
            
        }
        .onAppear {
            viewModel.fetchSongs()
        }

    }
}
