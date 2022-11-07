import SwiftUI
struct Movie: Decodable {
    let id: Int
    let title: String
    let posterpath: String
    let releasedate:String
    let overview:String
    let rating:Int
}
struct DemoData: Codable {
    let title: String
    let description: String
}
struct ContentView: View {
    @ObservedObject var imageLoader = ImageLoader()
    @State var movies = [Movie]()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(movies, id: \.title) { movie in
                    NavigationLink(destination: details(movie: movie)) {
                        HStack {
                            Image("Movie")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            Text(movie.title)
                                .font(.headline)
                        }.padding(7)
                    }
                }
            }
            .onAppear(perform: loadData)
            .navigationTitle("Movies")
            }
        
    }
    
    func loadData() {
        guard let url = URL(string: "https://preetampothala.github.io/testapi/moviestrending.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        print(request)
 
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                print(data)
                //pull out the declaration of the decoder object
                let decoder = JSONDecoder()
                //decode directly to an array of User structs rather than a Response
                if let decodedResponse = try?
                    decoder.decode([Movie].self, from: data) {
                    DispatchQueue.main.async {
                        //decodedResponse is now [Movie] rather than Response.Movie
                        self.movies = decodedResponse
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
 
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
