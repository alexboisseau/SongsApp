//
//  SongDetailView.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

struct SongDetailView: View {
    @ObservedObject private var viewModel: SongDetailViewModel
    
    init(viewModel: SongDetailViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        Text("Song Detail View")
    }
}
