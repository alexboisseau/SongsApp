//
//  ArtistsView.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

struct ArtistsView: View {
    @ObservedObject private var viewModel = ArtistsViewModel()
    
    
    var body: some View {
        if viewModel.artists.isEmpty {
            HStack {
                Spacer()
                Text("Add a new artist beau goss 🎉")
                Spacer()
            }
        } else {
            Text("Hello beau goss")
        }
    }
}

struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView()
    }
}
