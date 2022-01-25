//
//  AddArtistView.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

struct AddArtistView: View {
    @ObservedObject private var viewModel = AddArtistViewModel()
    @Binding var artist: Artist?
    
    var body: some View {
            Form {
                Section {
                    Toggle(isOn: $viewModel.addArtistFormIsShow) {
                        Text("Add a new artist")
                    }
                    .tint(.accentColor)
                }
                
                if viewModel.addArtistFormIsShow {
                    Section {
                        TextField ("First Name", text: $viewModel.firstName)
                        TextField ("Last Name", text: $viewModel.lastName)
                    } header: {
                        Text("Add a new artist")
                    }
                    
                    Button {
                        viewModel.addNewArtist()
                        viewModel.addArtistFormIsShow.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Add Artist")
                            Spacer()
                        }
                    }
                } else {
                    
                    if viewModel.artists.isEmpty {
                        Text("Please, add an artist")
                    } else {
                        Section {
                            List {
                                ForEach(viewModel.artists) { art in
                                    if let firstName = art.firstName, let lastName = art.lastName {
                                        Button {
                                            artist = art
                                        } label: {
                                            HStack(spacing: 10) {
                                                AsyncImage(url: art.avatarURL!) { phase in
                                                    switch phase {
                                                    case .empty:
                                                        ProgressView()
                                                    case .success(let image):
                                                        image.resizable()
                                                             .aspectRatio(contentMode: .fit)
                                                             .clipShape(Circle())
                                                             .frame(maxWidth: 30, maxHeight: 30)
                                                    case .failure:
                                                        Image(systemName: "photo")
                                                    @unknown default:
                                                        // Since the AsyncImagePhase enum isn't frozen,
                                                        // we need to add this currently unused fallback
                                                        // to handle any new cases that might be added
                                                        // in the future:
                                                        EmptyView()
                                                    }
                                                }
                                                
                                                VStack (alignment: .leading) {
                                                    Text(firstName)
                                                    Text(lastName)
                                                        .font(.caption)
                                                }
                                                .foregroundColor(.primary)
                                                
                                                Spacer()
                                                
                                                if artist == art {
                                                    Image(systemName: "checkmark")
                                                }
                                            }
                                    }
                                    }
                                }
                            }
                        } header: {
                            Text("Select an artist")
                        }
                    }
                }
                
            }
            .navigationTitle("Add Artist")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchArtists()
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert, actions: {
                Button("OK", role: .cancel) {
                    viewModel.fetchArtists()
                }
            }, message: {
                Text(viewModel.alertMessage)
            })
    }
}
