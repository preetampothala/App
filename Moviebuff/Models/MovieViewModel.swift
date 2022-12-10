import SwiftUI

class MovieViewModel: ObservableObject{
    private let apiKey = "api_key=e418fdbca3c905f8b53cababd0a32c2f"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    @Published var movies:[Movie]?
    @Published var movie: Movie?
    var isFetchingData=false;
    func fetchMovieData(with url:String){
        let appendedURL:String="\(baseAPIURL)\(url)&\(apiKey)";
        let fetchURL = URL(string: appendedURL)
        URLSession.shared.dataTask (with:fetchURL!) { data, response, error in
            if let error=error{
                print(error)
                return
            }
            if let data=data{
                do{
                    let discover = try JSONDecoder().decode(Discover.self, from: data)
                    DispatchQueue.main.async {
                        self.movies=discover.results
                    }
                    
                }catch (let error){
                    print(error)
                    return
                }
            }else{
                    print("error")
                    return
                }
        }.resume()
        }
    func fetchMovieDetail(movie: Movie){
        let fetchURL = URL(string: "\(baseAPIURL)/movie/\(movie.id)?&api_key=e418fdbca3c905f8b53cababd0a32c2f")
        URLSession.shared.dataTask (with:fetchURL!) { data, response, error in
            self.isFetchingData=false
            if let error=error{
                print(error)
                return
            }
            if let data=data{
                do{
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    DispatchQueue.main.async {
                        self.movie = movie
                    }
                    
                }catch (let error){
                    print(error)
                    return
                }
            }else{
                    print("error")
                    return
                }
        }.resume()
        }
    }

