import SwiftUI
import Foundation
struct Discover: Decodable{
    let results:[Movie]
}


struct Movie: Identifiable, Decodable{
    let id:Int
    let title: String
    let overview:String?
    let poster_path: String
    let backdrop_path:String
    let vote_average: Float
    let release_date: String
    let genres: [Genre]?
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdrop_path )")!
    }
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)")!
    }
    
    var ratingText: String {
        let rating = Int(vote_average)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
}
struct Genre: Codable, Equatable {
    var id: Int
    let name: String
}

extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: Discover? = try? Bundle.main.loadAndDecodeJSON(filename: "movie-list")
        print(response?.results as Any)
        return response?.results ?? [Movie]()
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
    
}

class Utils {
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
}

extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
