
import SwiftUI

struct PosterCarouselView: View {
    let title: String
    let movies: [Movie]
    @ObservedObject var viewModel: MovieViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: DetailsView(movie: movie, viewModel: viewModel)) {
                            PosterView(movie: movie, viewModel: viewModel)
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
        
    }
}

struct PosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PosterCarouselView(title: "Now Playing", movies: Movie.stubbedMovies,viewModel: MovieViewModel())
    }
}


