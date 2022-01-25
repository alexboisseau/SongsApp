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
        
        AsyncImage(url: URL(string: "https://api.lorem.space/image/album?w=280&h=280")) { image in
            image.resizable()
        } placeholder: {
            Color.red
        }
        .frame(width: 280, height: 280)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 10)
        
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.song.title ?? "")
                    .font(.title3)
                    .bold()
                Text(viewModel.song.artist?.firstName ?? "")
                    .font(.body)
            }
            
            Spacer()
            
            RatingView(title: nil, rating: $viewModel.song.rate)
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
        
        Spacer()
    }
}
