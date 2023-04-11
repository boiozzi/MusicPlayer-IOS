//
//  ContentView.swift
//  music_streaming
//
//  Created by Austin Long on 2023-03-16.
//

import SwiftUI

struct Album: Hashable{
    var id = UUID()
    var name: String
    var image: String
    var songs: [Song]
}

struct Song: Hashable{
    var id = UUID()
    var name: String
    var time: String
}

struct ContentView: View {
    
    var albums = [Album(name: "Midnight", image: "1",
                        songs: [Song(name: "Snows", time: "3:55"),
                                Song(name: "Hello", time: "2:43"),
                                Song(name: "Melodrama", time: "3:55"),
                                Song(name: "Green Light", time: "2:43"),
                                Song(name: "Sober", time: "3:55"),
                                Song(name: "The Louvre", time: "2:43")]),
                  
                  Album(name: "FlashBall", image: "3",
                        songs: [Song(name: "Dance the Night Away", time: "2:45"),
                                Song(name: "Kitsch", time: "3:54"),
                                Song(name: "Liability", time: "3:55"),
                                Song(name: "Sober II", time: "2:43"),
                                Song(name: "Sober III", time: "3:55"),
                                Song(name: "Supercut", time: "2:43")]),
                  
                  Album(name: "Fancy", image: "4",
                        songs: [Song(name: "FIRE", time: "3:11"),
                                Song(name: "fLOWERS", time: "3:54"),
                                Song(name: "Moscow Mule", time: "3:55"),
                                Song(name: "No Room", time: "2:43"),
                                Song(name: "Ugly", time: "3:55"),
                                Song(name: "GOTTA BE YOU", time: "2:43")]),
                  
                  Album(name: "Kitzuma", image: "2",
                        songs: [Song(name: "aTTENtion", time: "3:55"),
                                Song(name: "Hype Boy", time: "3:23"),
                                Song(name: "What is Love", time: "3:55"),
                                Song(name: "Lemon", time: "2:43"),
                                Song(name: "Promiss You", time: "3:55"),
                                Song(name: "STEREOTYPE", time: "2:43"),
                                Song(name: "The Bell", time: "3:55"),
                                Song(name: "Teddy Bear", time: "2:43"),
                                Song(name: "ASAP", time: "2:43")])]
    
    @State private var currentAlbum: Album?
    
    var body: some View {
        NavigationView{
            ScrollView{
                ScrollView(.horizontal, showsIndicators: false,
                           content: {
                    LazyHStack{
                        ForEach(self.albums, id: \.self, content: {
                            album in
                            AlbumArt(album: album).onTapGesture {
                                self.currentAlbum = album
                            }
                        })
                    }
                })
                LazyVStack{
                    ForEach((self.currentAlbum?.songs ?? self.albums.first?.songs) ?? [Song(name: "Snows", time: "3:55"),
                                                                                       Song(name: "Hello", time: "2:43")],
                            id: \.self,
                            content: {
                            song in
                              Songcell(song: song)
                })
                }
            }.navigationTitle("Your Library")
        }
    }
}

struct AlbumArt: View{
    var album: Album
    var body: some View{
        ZStack{
            Image(album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 220, height: 300, alignment: .center)
            ZStack{
                Text(album.name).foregroundColor(.white)
            }.frame(height: 60, alignment: .center)
        }.frame(width: 170, height: 200, alignment: .center)
            .clipped()
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(20)
            }
        }

struct Songcell: View{
    var song: Song
    var body: some View{
        HStack{
            ZStack{
                Circle().frame(width: 50, height: 50, alignment: .center).foregroundColor(.red)
                Circle().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
            }
            Text(song.name).bold()
            Spacer()
            Text(song.time)
        }.padding(20)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumArt(album: Album(name: "Midnight", image: "1",
                                    songs: [Song(name: "Snows", time: "3:55"),
                                            Song(name: "Hello", time: "2:43")]))
    }
}
