//
//  PairController.swift
//  Pair
//
//  Created by Heli Bavishi on 12/18/20.
//

import Foundation

class PairController {
    
    static let sharedInstance = PairController()
    
    var pairs: [Pair] = []
    
    init() {
        loadPersistance()
    }
    //MARK: - CRUD
    
    //create
    
    func addName(name: String){
        let name = Pair(name: name)
        pairs.append(name)
        saveToPersistance()
    }
    
    //delete
    func removeName(pair : Pair){
        guard let index = pairs.firstIndex(of: pair) else { return }
        pairs.remove(at: index)
        saveToPersistance()
    }
    
    //update
    func updateName(pair: Pair, name: String){
        pair.name = name
        saveToPersistance()
    }
    
    //MARK: - Persistance
    
    func createFileForPersistance() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Pair.json")
        return fileURL
    }
    
    func saveToPersistance(){
        let jsonEncoder = JSONEncoder()
        do {
            let jsonPair = try jsonEncoder.encode(pairs)
            try jsonPair.write(to: createFileForPersistance())
        } catch let encodingError {
            print("There was an error encoding the data \(encodingError.localizedDescription)")
        }
    }
    
    func loadPersistance() {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedPair = try Data(contentsOf: createFileForPersistance())
            pairs = try jsonDecoder.decode([Pair].self, from: decodedPair)
        } catch let decodingError {
            print("There was an error decoding data \(decodingError.localizedDescription)")
            
        }
    }
}//End of class
