//
//  music.swift
//  Mobiilirakendus
//
//  Created by Johannes Kollist on 10.05.2022.
//

import Foundation
import SwiftUI


struct music: View {
    @State private var playlist = [Result]()
    @State private var currentScreen: screen = .songs
    @State private var results = [Result]()
    @State private var searchText: String = ""
    enum screen{
        case songs
        case playlist
    }
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    currentScreen = .songs
                }){
                Text("Songs")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(currentScreen == .songs ? Color.blue : Color.white)
                        .cornerRadius(8)
                        .foregroundColor(currentScreen == .songs ? Color.white : Color.black)
                }
                Button(action: {
                    currentScreen = .playlist
                }){
                Text("My playlist")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(currentScreen == .playlist ? Color.blue : Color.white)
                        .cornerRadius(8)
                        .foregroundColor(currentScreen == .playlist ? Color.white : Color.black)
                }
            } .padding(.top, currentScreen == .playlist ? 52: 0)
                .padding(.horizontal)
            switch currentScreen {
            case .songs:
                List(results, id: \.trackId) { item in
                    Button (action: {
                        if !playlist.contains(where: { $0.trackId == item.trackId }){
                            playlist.append(item)
                        }
                    }){
                        VStack(
                        alignment: .leading){
                            Text(item.trackName)
                                .font(.headline)
                            Text(item.collectionName)
                        }
                    }
                   
                    
                }
                .listStyle(.plain)
                .searchable(text: $searchText)
                .onChange(of: searchText){
                    value in
                    searchText = value
                    async{
                        await loadData(artistName: searchText)
                    }
                }
            case .playlist:
                List{
                    ForEach(playlist, id: \.trackId){item in
                    VStack(
                    alignment: .leading){
                        Text(item.trackName)
                            .font(.headline)
                        Text(item.collectionName)
                    }
                }
                .onDelete(perform: delete)}
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func delete(offset: IndexSet) {
        playlist.remove(atOffsets: offset)
    }
    
    func loadData(artistName: String) async{
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(artistName)&entity=song") else{
            print("invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                results = decodedResponse.results
            }
        }catch {
            print("Invalid Data")
        }
    }
}

