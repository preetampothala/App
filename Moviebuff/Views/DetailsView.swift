
import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    var movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    
    var body: some View {
        ZStack {
            if viewModel.movie != nil {
                MovieDetailListView(movie: self.viewModel.movie!)
            }
        }
        .navigationBarTitle(viewModel.movie?.title ?? "")
        .onAppear {
            self.viewModel.fetchMovieDetail(movie: self.movie)
        }
    }
}

struct MovieDetailListView: View {
    let movie: Movie
    var body: some View {
        List {
            MovieDetailImage(imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            HStack {
                Text(movie.genreText)
            }
            Text(movie.overview ?? "")
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            
        }
    }
}
        


struct MovieDetailImage: View {
    let imageURL: URL
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            WebImage(url:URL(string:"\(imageURL)" ))
                    .resizable()
            
        }
        .aspectRatio(16/9, contentMode: .fit)
//        .onAppear {
//            WebImage(url:URL(string:"\(imageURL)" ))
//        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView(movie: Movie.stubbedMovies[0],viewModel: MovieViewModel())
        }
    }
}

