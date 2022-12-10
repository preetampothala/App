
import SwiftUI

struct MovieListView: View {
    @ObservedObject private var nowPlayingState = MovieViewModel()
    @ObservedObject private var bestDramasState = MovieViewModel()
    @ObservedObject private var topRatedState = MovieViewModel()
    @ObservedObject private var popularState = MovieViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Group{
                    if nowPlayingState.movies != nil {
                        PosterCarouselView(title: "Now Playing", movies: nowPlayingState.movies!, viewModel: nowPlayingState)
                    }else {
                        LoadingView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                Group {
                    if bestDramasState.movies != nil {
                        BackdropCarouselView(title: "Best Dramas", movies: bestDramasState.movies!, viewModel: nowPlayingState)
                    }
                    else {
                        LoadingView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                Group {
                    if topRatedState.movies != nil {
                        BackdropCarouselView(title: "Top Rated", movies: topRatedState.movies!, viewModel: nowPlayingState)
                    }
                    else {
                        LoadingView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if popularState.movies != nil {
                        BackdropCarouselView(title: "Popular", movies: popularState.movies!, viewModel: nowPlayingState)
                    }
                    else {
                        LoadingView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                
            }
            .navigationBarTitle("Movies")
        }
        .onAppear {
            self.nowPlayingState.fetchMovieData(with: "/discover/movie?primary_release_date.gte=2022-10-15&primary_release_date.lte=2022-11-04")
            self.bestDramasState.fetchMovieData(with: "/discover/movie?with_genres=18&primary_release_year=2022")
            self.topRatedState.fetchMovieData(with: "/discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc")
            self.popularState.fetchMovieData(with: "/discover/movie?primary_release_date.gte=2022-10-15&primary_release_date.lte=2022-11-04")
        }
        
    }
}


struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

struct LoadingView: View{
    var body: some View{
        Text("Fetching Data ...")
    }
    
}
