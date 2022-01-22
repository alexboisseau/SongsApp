//
//  Persistence.swift
//  Songs
//
//  Created by Alex Boisseau on 19/01/2022.
//

import CoreData

struct DBManager {
    static let shared = DBManager()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Songs")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK : - Songs
    func getAllSongs() -> Result<[Song], Error> {
        let fetchRequest = Song.fetchRequest()
        let descriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
        
        fetchRequest.sortDescriptors = [descriptor]
        
        let context = container.viewContext
        
        do {
            let songs = try context.fetch(fetchRequest)
            return .success(songs)
        } catch {
            return .failure(error)
        }
    }
    
    func getSong(by id: NSManagedObjectID) -> Result<Song, Error> {
        let context = container.viewContext
        
        do {
            let song = try context.existingObject(with: id) as! Song
            return .success(song)
        } catch {
            return .failure(error)
        }
    }
    
    @discardableResult
    func addSong(
        coverURL: URL,
        lyrics: String?,
        title: String,
        rate: Int64,
        releaseDate: Date,
        isFavorite: Bool = false
    ) -> Result<Song, Error> {
        let context = container.viewContext
        
        // DUMMY DATA
        let artistsRes = getAllArtists()
        let artist: Artist?
        
        switch artistsRes {
        case .failure(let error): artist = nil
        case .success(let artists): artist = artists.first
        }
        
        let song = Song(entity: Song.entity(), insertInto: DBManager.shared.container.viewContext)
        
        song.title = title
        song.releaseDate = releaseDate
        song.rate = Int64(rate)
        song.coverURL = URL(string: "https://api.lorem.soace/image/album")
        song.isFavorite = isFavorite
        song.lyrics = "bla bla bla"
        song.artist = artist
        
        do {
            try context.save()
            return .success(song)
        } catch {
            return .failure(error)
        }
    }
    
    @discardableResult
    func deleteSong(by id: NSManagedObjectID) -> Result<Void, Error> {
        let context = container.viewContext

        do {
            let song = try context.existingObject(with: id)
            context.delete(song)
            try context.save()

            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    // MARK : - Artist
    
    @discardableResult
    func addArtist(
        firstName: String,
        lastName: String,
        coverURL: URL,
        songs: [Song]
    ) -> Result<Artist, Error> {
        let context = container.viewContext
        
        let artist = Artist(entity: Artist.entity(), insertInto: context)
        artist.firstName = firstName
        artist.lastName = lastName
        artist.avatarURL = coverURL
        artist.songs?.addingObjects(from: songs)
        
        do {
            try context.save()
            return .success(artist)
        } catch {
            return .failure(error)
        }
    }
    
    func addDefaultArtist() {
        let artistResult = getAllArtists()
        
        switch artistResult {
        case .success(let artists):
            if artists.isEmpty {
                addArtist(firstName: "William",
                          lastName: "Nzobazola",
                          coverURL: URL(string: "https://api.lorem.space/image/face?w=150&h=150")!,
                          songs: [])
            }
            
        case .failure: return
        }
    }
    
    @discardableResult
    func getAllArtists() -> Result<[Artist], Error> {
        let fetchRequest = Artist.fetchRequest()
        let descriptor = NSSortDescriptor(key: "lastName", ascending: true)
        
        fetchRequest.sortDescriptors = [descriptor]
        
        let context = container.viewContext
        
        do {
            let artists = try context.fetch(fetchRequest)
            return .success(artists)
        } catch {
            return .failure(error)
        }
    }
}
