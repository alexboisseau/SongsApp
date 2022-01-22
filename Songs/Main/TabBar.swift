//
//  TabBar.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

struct TabBar: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            SongsView().tabItem {
                Label("Songs", systemImage: "music.note.list")
            }.tag(0)
            
            FavoritesView().tabItem {
                Label("Favorites", systemImage: "star")
            }
        }.onAppear {
            DispatchQueue.main.async {
                DBManager.shared.addDefaultArtist()
            }
        }
    }
}
