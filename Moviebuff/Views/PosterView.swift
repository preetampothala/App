import SwiftUI
import SDWebImageSwiftUI

struct PosterView: View {
    let movie: Movie
    @ObservedObject var viewModel:MovieViewModel
    var body: some View {
        ZStack {
            WebImage(url:URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: movie.poster_path))"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
        }
        .frame(width: 204, height: 306)
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(movie: Movie(id: 0, title: "", overview: "", poster_path: "/tegBpjM5ODoYoM1NjaiHVLEA0QM.jpg", backdrop_path: "", vote_average: 0.3, release_date: "", genres: [Genre]()), viewModel: MovieViewModel())
    }
}
