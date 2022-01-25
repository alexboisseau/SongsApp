//
//  SongDetailView.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import SwiftUI

struct SongDetailView: View {
    @Binding var song: Song?
    
    var body: some View {
        if song != nil {
            VStack {
                AsyncImage(url: song!.coverURL!) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxWidth: 80, maxHeight: 80)
                             .padding(50)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 80, maxHeight: 80)
                            .padding(50)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Feu de bois")
                        Text("Damso")
                            .font(.caption)
                    }
                    
                    Spacer()
                
                }
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}
