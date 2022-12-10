
import SwiftUI

import SwiftUI
import SDWebImageSwiftUI

struct WatchlistView: View {
    @ObservedObject var viewModel=MovieViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                if let movies=viewModel.movies{
                    MovListView(movies: movies, viewModel:viewModel)
                }else{
                    LoadingView()
                }
            }.navigationTitle("Watchlist")
            }
        .onAppear(){
            viewModel.fetchMovieData(with: "/discover/movie?primary_release_date.gte=2022-10-15&primary_release_date.lte=2022-11-04")
        }
    }
}

struct MovieView: View{
    var movie: Movie
    var body: some View{
  
                HStack{
                    Image(systemName: "circle")
                    WebImage(url:URL(string:
                "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:120,height: 200)
                        .cornerRadius(8)
                    VStack(alignment: .leading, spacing: 8){
                        /*@START_MENU_TOKEN@*/Text(movie.title)/*@END_MENU_TOKEN@*/
                            .font(.title2)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        Text(movie.overview ?? "")
                            .lineLimit(4)
                        Spacer()
                        HStack(spacing:4){
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 14,height: 14)
                                .foregroundColor(.green)
                            Text(String(format:"%.1f",movie.vote_average))
                                .fontWeight(.semibold)
                        }
                    }.padding(.vertical)
                }.listStyle(PlainListStyle())
    }

}
struct MovListView: View{
    var movies:[Movie]
    @ObservedObject var viewModel: MovieViewModel
    var body: some View{
        List{
            ForEach(movies) { movie in
                NavigationLink(
                destination: DetailsView(movie: movie, viewModel: viewModel),
                label: {
                    MovieView(movie: movie)
                        .padding(.vertical)
                }
                )
               
            }
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}
