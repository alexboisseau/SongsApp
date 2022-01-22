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
                    Text("Add a new song beau goss 🎉")
                    Spacer()
                }
                .navigationBarItems(
                    trailing:
                        Button {
                            viewModel.showAddSongView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                )

            } else {
                List {
                        ForEach(viewModel.songs) { song in
                            if let title = song.title, let songArtistName = song.artist {
                                HStack {
                                    Text(title)
                                    Spacer()
                                    Text(song.artist?.firstName ?? "Anonymous 👻")
                                        .font(.caption)
                                }
                            }
                            
                        }.onDelete { offsets in
                            viewModel.deleteSong(at: offsets)
                        }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Songs")
                .animation(.easeInOut, value: viewModel.songs)
                .navigationBarItems(
                    trailing:
                        Button {
                            viewModel.showAddSongView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                )
            }
        }
        .sheet(isPresented: $viewModel.showAddSongView) {
            viewModel.fetchSongs()
        } content: {
            AddSongView()
        }
        .onAppear {
            viewModel.fetchSongs()
        }

    }
}
