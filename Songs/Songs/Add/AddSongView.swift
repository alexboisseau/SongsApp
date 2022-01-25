//
//  AddSongView.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

struct AddSongView: View {
    @ObservedObject private var viewModel = AddSongViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField ("Song Title", text: $viewModel.songTitle)
                    DatePicker("Release Date", selection: $viewModel.releaseDate, displayedComponents: .date)
                    RatingView(title: "Rate", rating: $viewModel.rate)
                } header: {
                    Text("Song")
                }
                
                Section{
                    NavigationLink {
                        AddArtistView(artist: $viewModel.artist)
                    } label: {
                        HStack {
                            Text("Add an artist")
                            if viewModel.artist?.firstName != nil {
                                Spacer()
                                Text(viewModel.artist!.firstName!)
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                } header: {
                    Text("Artist")
                }
                
                Section {
                    Toggle(isOn: $viewModel.isFavorite) {
                        Text("Do you love this song ?")
                    }
                    .tint(.accentColor)
                } header: {
                    Text("Favorite")
                }
                
                Button {
                    viewModel.addSong()
                } label: {
                    HStack {
                        Spacer()
                        Text("Add song")
                        Spacer()
                    }
                }
            }
            .onAppear(perform: {
                if viewModel.artist != nil {
                    let songArtist = viewModel.artist!
                    print(songArtist.firstName!)
                }
            })
            .navigationTitle("Add Song")
            .navigationBarTitleDisplayMode(.inline)
            .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert, actions: {
                Button("OK", role: .cancel) {
                    presentationMode.wrappedValue.dismiss()
                }
            }, message: {
                Text(viewModel.alertMessage)
            })
        }
    }
}

struct AddSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddSongView()
    }
}
